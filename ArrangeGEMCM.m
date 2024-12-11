function [subject_data] = ArrangeGEMCM(data, gene, varargin)
% F
% Function arranges neuroimaging modalities and gene expression according to GE-MCM 
% USAGE: ArrangeGEMCM(data, gene, varagin)
%
% INPUT: data     = struct data containing modalities and time points.
%                   data.norm_data and data.time_adj columns contain normalized imaging modalities 
%                   and the actual age of subject at time of measurement
% 
%        gene     = normalized gene expression matrix. Rows correspond to brain regions 
%                   and columns correspond to genes
%        
%        varargin = an initial or equilibrium state of imaging modalities obtained from a combination of healthy subjects at baseline
%                   size is a column vector having (number of regions * number of imaging modalities) rows

% OUTPUT: subject_data = struct data containing the three parts of GE-MCM equation: 
%                        i.e; dS/dt, S * gene expression, and S * connectivity
% 
% QA, NeuroPM Lab, MNI, October 2024


p = inputParser;
addRequired(p, 'data', @(x) isstruct(x));
addRequired(p, 'gene', @(x) ismatrix(x) && isfloat(x));
addOptional(p, 'S0_population', @(x) isfloat(x));

parse(p, data, gene, varargin{:});

data = p.Results.data;
gene = p.Results.gene;
S0_population = p.Results.S0_population;


N_regions = size(gene,1);
N_subject = length(data);
N_fac = size(data(1).times, 1);

chosen_subj_indices = [];
N_chosen_subj = 0;

for subj = 1:N_subject

    disp(['Taking data, subject ' num2str(subj)]);

    %% Decide if the baseline imaging should be subtracted or not
    if ~isempty(varargin)
        S = data(subj).norm_data - repmat(S0_population,[1 size(data(subj).norm_data,2)]);
    else
        S = data(subj).norm_data;
    end

    time = data(subj).times_adj;
    C = data(subj).conn1;

    %% Calculate dS/dt, Change in imaging factor at each region with change in time
    unused_time_points = [];

    for fac = 1:N_fac
        visit_with_imput = numel (S(N_regions*(fac - 1)+1, :)) - 1;  %visit count including imputed
        [actual_visit_S, actual_vis_index]= unique (S(N_regions*(fac - 1)+1, :),'stable');
        unused_time_points = [unused_time_points setdiff(1:numel(S(N_regions*(fac - 1)+1, :)),actual_vis_index)];
    end

    unused_time_points = unique(unused_time_points);
    used_time_points = setdiff(1:numel(S(N_regions*(fac - 1)+1, :)),unused_time_points);
    if ~isempty(used_time_points) && length(used_time_points)>1

        %% keep indices of subjects chosen
        chosen_subj_index = subj;
        chosen_subj_indices = [chosen_subj_indices; chosen_subj_index];

        fac_time = time (1, used_time_points);
        dt = diff(fac_time);
        dS = diff(S(:,used_time_points),[], 2);
        dS_dt =  dS./dt;
        S_data  = S(:,used_time_points);

        %% Multiply imaging factors (S) with gene expression (GE)
        SGE_subj = [];
        for visit = 1:size (S_data,2)-1
            S1_Sn  = reshape(S_data(:,visit), [], N_fac);
            for reg = 1:N_regions
                SGE (:, reg) = reshape (S1_Sn(reg, :).*gene(reg,:)', [], 1);
            end
            SGE_visit = [S1_Sn SGE'];
            SGE_subj = [SGE_subj; SGE_visit];
        end


        %% Multiply the imaging factors (S) with connectivity matrix (C)
        CS_subj = [];
        for visit = 1:size (S_data,2)-1
            Si = S_data(:,visit);
            for j = 1:size(S_data,1)
                for i = 1:size(S_data,1)
                    change_in_S(i,j) = Si(i)- Si(j);
                end
            end

            %% Add the C*S together
            CS_visit = [];
            for n = 1:N_fac
                add_all_CS = diag (C * change_in_S (N_regions*(n-1)+1:N_regions*n, N_regions*(n-1)+1:N_regions*n));                       %extract each %Si-Sj and repeat for number of time points
                CS_visit = [CS_visit; add_all_CS];
            end
            CS_subj = [CS_subj CS_visit];
        end

        N_chosen_subj = N_chosen_subj+1;

        for k = 1:N_fac
            subject_data(N_chosen_subj).factor(k).dS_dt = reshape (dS_dt (N_regions*(k-1)+1:N_regions*k,:), [], 1);
            subject_data(N_chosen_subj).factor(k).CS = reshape (CS_subj(N_regions*(k-1)+1:N_regions*k,:),[], 1);
        end
        subject_data(N_chosen_subj).S_GE = SGE_subj;
        subject_data(N_chosen_subj).Id = data(chosen_subj_index).id;
    end
end
end