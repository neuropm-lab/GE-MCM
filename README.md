# **GE-MCM: Gene Expression Multifactorial Causal Model**

A multiscale mathematical model that concurrently accounts for the direct influence of hundreds of genes on regional macroscopic brain neuroimaging phenotypes, the pathological spreading of the ensuing aberrations across axonal and vascular networks, and the resultant effects of these alterations on clinical manifestations. 

![GE-MCM](https://github.com/user-attachments/assets/647b1e43-be4c-4aea-95b7-82167703bf9b)

## **Description**
The scripts are for spatiotemporal causal model of multi-modal neuroimaging variables, based on Iturria-Medina et al., 2017 (https://doi.org/10.1016/j.neuroimage.2017.02.05), and extended with molecular template data (gene expression and neurotransmitter receptor maps) in Adewale et al., 2021 (https://doi.org/10.7554/eLife.62589), Khan et al., 2022 (https://doi.org/10.1093/brain/awab375), Khan et al., 2023 (https://doi.org/10.1038/s41467-023-41677-w), and Adewale et al., 2024 (https://doi.org/10.1038/s41531-025-00878-4).

(c) Neuroinformatics for Personalized Medicine Lab (Neuro-PM): https://www.neuropm-lab.com/

Authors: Quadri Adewale, Ahmed Faraz Khan, and Yasser Iturria-Medina

Contact information: quadri.adewale@mail.mcgill.ca; yasser.iturriamedina@mcgill.ca

## **Scripts and Workflow**
GE-MCM can be used with longitudinal and multi-modal neuroimaging (MRI, PET, SPECT, etc.) and gene expression data at single or multiple time points.

### **Step 0: Preprocessing and harmonization**
Preprocess raw data as appropriate using tools of the user's choice:

* Motion correction, slice timing correction, artefact removal, etc.
* Alignment to T1 image
* Spatial normalization to MNI template
* Harmonization for site and scanner variations (e.g., using ComBat, https://github.com/Jfortin1/ComBatHarmonization)

### **Step 1: Compile the MCM data structure using NeuroPM-box**
Organize the harmonized NIFTI files for all subjects and neuroimaging modalities as described in the NeuroPM-box instructions.

NeuroPM-box can be downloaded from https://www.neuropm-lab.com/neuropm-box-download.html

### **Step 2: Load data structure, molecular templates, and anatomical connectivity matrix**

Use [**ArrangeGEMCM.m**](/ArrangeGEMCM.m) to arrange gene expression and lognitudinal neuroimaging modalities according to the GE-MCM model.

### **Step 3: Fit GE-MCM models**

Use [**bhs.m**](/bhs.m) (Bayesian regression with horshoe prior) for model fitting and parameter estimation. Other regression methods can be employed.

### **Step 4: Downstream analysis**
Use GE-MCM outputs (model parameters) for inter-subject comparisons (e.g., with clinical evaluations, physical activity, etc.).


## **Citations**

Please cite NeuroPM-box and the relevant molecular-MCM paper from the following:

* NeuroPM-box: Iturria-Medina, Y., Carbonell, F., Assadi, A. et al. Integrating molecular, histopathological, neuroimaging and clinical neuroscience data with NeuroPM-box. Commun Biol 4, 614 (2021). https://doi.org/10.1038/s42003-021-02133-x

* Molecular-MCM (gene expression)
  * Adewale, Q., Khan, A.F., Carbonell, F., & Iturria-Medina, Y., Integrated 
    transcriptomic and neuroimaging brain model decodes biological mechanisms in aging 
    and Alzheimer’s disease. eLife 10:e62589 (2021). https://doi.org/10.7554/eLife.62589

  * Adewale, Q., Khan, A.F., Lin, SJ. et al. Patient-centered brain transcriptomic and 
    multimodal imaging determinants of clinical progression, physical activity, and 
    treatment needs in Parkinson’s disease. npj Parkinsons Dis. 11, 29 (2025). 
    https://doi.org/10.1038/s41531-025-00878-4

* Molecular-MCM (neurotransmitter receptors): Khan, A.F., Adewale, Q., Lin, SJ. et al. Patient-specific models link neurotransmitter receptor mechanisms with motor and visuospatial axes of Parkinson’s disease. Nat Commun 14, 6009 (2023). https://doi.org/10.1038/s41467-023-41677-w


    
