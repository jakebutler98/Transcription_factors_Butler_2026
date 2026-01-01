# This directory contains the scripts and files used to run TOBIAS for the active disease vs healthy analysis.

## To recreate analysis please run files in following order:

### 1 - ATACorrect_CD4.sh
Corrects Tn5 bias in the ATAC-seq data for active disease and healthy CD4 samples. This script requires:
- HEALTHY_CD4_merged_output_test.bam
- ACTIVE_DISEASE_CD4_merged_output_test.bam
- genome.fa
- peak file containing all regions for which footprinting will occur
- hg38-blacklist.v2.bed

### 2 - FootprintScores_CD4.sh
Calculates footprint scores for the ATAC-seq data for healthy samples. This script requires:
- Corrected ATAC-seq data from the previous step
- peak file containing all regions for which footprinting will occur

### 3 - BINDetect_CD4.sh
Combines footprint scores with the information of transcription factor binding motifs to detect the presence of transcription factor binding events. This script requires:
- motif file
- footprint scores from the previous step
- genome.fa
- peak file containing all regions for which footprinting will occur

### 4 - ATACorrect_CD8.sh
As above, but for CD8 samples.

### 5 - FootprintScores_CD8.sh
As above, but for CD8 samples.

### 6 - BINDetect_CD8.sh
As above, but for CD8 samples.
