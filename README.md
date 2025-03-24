# **GE-MCM: Gene Expression Multifactorial Causal Model**
![GE-MCM](https://github.com/user-attachments/assets/647b1e43-be4c-4aea-95b7-82167703bf9b)


A multiscale mathematical model that concurrently accounts for the direct influence of hundreds of genes on regional macroscopic brain neuroimaging phenotypes, the pathological spreading of the ensuing aberrations across axonal and vascular networks, and the resultant effects of these alterations on clinical manifestations. 

The scripts are for spatiotemporal causal model of multi-modal neuroimaging variables, based on Iturria-Medina et al., 2017 (https://doi.org/10.1016/j.neuroimage.2017.02.05), and extended with molecular template data (gene expression and neurotransmitter receptor maps) in Adewale et al., 2021 (https://doi.org/10.7554/eLife.62589), Khan et al., 2022 (https://doi.org/10.1093/brain/awab375), Khan et al., 2023 (https://doi.org/10.1038/s41467-023-41677-w), and Adewale et al., 2024 (https://doi.org/10.1038/s41531-025-00878-4).

(c) Neuroinformatics for Personalized Medicine Lab (Neuro-PM): https://www.neuropm-lab.com/

Authors: Quadri Adewale, Ahmed Faraz Khan, and Yasser Iturria-Medina

Contact information: quadri.adewale@mail.mcgill.ca; yasser.iturriamedina@mcgill.ca

## **Description**
**ArrangeGEMCM.m** - Arranges gene expression and lognitudinal neuroimaging modalities according to the GE-MCM model

**bhs.m** - Bayesion regression with horshoe prior for parameter estimation. It takes the output from ArrangeGEMCM.m

## **Citations**
Quadri Adewale, Ahmed F Khan, Felix Carbonell, Yasser Iturria-Medina, Alzheimer's Disease Neuroimaging Initiative (2021) Integrated transcriptomic and neuroimaging brain model decodes biological mechanisms in aging and Alzheimer’s disease eLife 10:e62589

    
