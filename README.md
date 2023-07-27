# VA_MVP_Illumina_Transfer
GitHub Transfer Directory

Summary File: "snv-consistency-table.csv"
  Columns: Exp_Key,Product,Probe_ID,Tot_Cnt,Mat_Cnt,Per
    Exp_Key: Experiment Key. This defines the parameters used in the analysis. gts_min defines the minimum Genotype Score threshold. 
    
    Product: This should really be called "Probe Partition" but it basically shows which partition of snv probes were analyzed. VA = 211 VA selected probes from EPICv1. v2-only are the unique probes from EPICv2. v3-only are the remaning overlap from EPICv1 and EPICv2, but not including VA probes.   
    Probe_ID: This is the Probe_ID from the manifest.
    Tot_Cnt: Total number of snv calls given the Experiment and Parameters.
    Mat_Cnt: Total number of agreed calls for the Experiment and Parameters.
    Per: Mat_Cnt / Tot_Cnt

Presentation: "EPICv2_Docker_Fingerprinting.20072023.v5.pptx"
  Presented on July 20th to the VA Team.

Directories:
  Idats: Raw Idat directory. 
  shells: Example shell scripts to run docker image.
  scratch: Original location to store Illumina data, however its current incomplete becuase it takes too long to load small subsets of data via git. If requested this can be updated. 
  data: Raw data used in analysis. Again, this can be updated more upon request, but still takes a lot of time.

# End of file
