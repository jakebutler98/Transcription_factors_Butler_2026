#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/HINT_ATAC/matching_log_active_disease.txt
#$ -N HINT_footprint_4                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 4

#$ -t 1-4
INDEX=$((SGE_TASK_ID))

module load functional_genomics/peak/rgt/1.0.2

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

footprint_predictions_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/HINT_ATAC/ACTIVE_DISEASE/matching/mid_stringent"

bed_files=("HEALTHY_CD4.bed" "HEALTHY_CD8.bed" "ACTIVE_DISEASE_CD4.bed" "ACTIVE_DISEASE_CD8.bed")

footprint_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/HINT_ATAC/ACTIVE_DISEASE/footprinting"

# The line `bed_file="/${bed_files[INDEX-1]}"` is creating a variable `bed_file` that
# stores the path to a specific BED file based on the value of `INDEX`.
bed_file="${footprint_dir}/${bed_files[INDEX-1]}"

jaspar_motifs="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/PsA_analysis/input/raw/custom_jaspar_homo_sapiens_2024"

# Execute the following command to do motif matching for footprints using motifs from JASPAR as default:

rgt-motifanalysis matching --organism=hg38 --fpr 0.0001 --motif-dbs ${jaspar_motifs} --output-location ${footprint_predictions_dir} --input-files ${bed_file}

## format output mpbs bed file for downstream analysis
# specifically, we need to remove trailing whitespace from this file. The above produces 4 files for the 4 inputs, so we need to do this for each file.
# The 4 files output should be:
# HEALTHY_CD4_mpbs.bed  HEALTHY_CD8_mpbs.bed  ACTIVE_DISEASE_CD4.bed  ACTIVE_DISEASE_CD8.bed
# The following command should be run on each of these files:

cd ${footprint_predictions_dir}

awk 'NF > 0 { gsub(/\t$/, ""); print }' HEALTHY_CD4_mpbs.bed > HEALTHY_CD4_mpbs.bed.tmp && mv HEALTHY_CD4_mpbs.bed.tmp HEALTHY_CD4_mpbs.bed
awk 'NF > 0 { gsub(/\t$/, ""); print }' HEALTHY_CD8_mpbs.bed > HEALTHY_CD8_mpbs.bed.tmp && mv HEALTHY_CD8_mpbs.bed.tmp HEALTHY_CD8_mpbs.bed
awk 'NF > 0 { gsub(/\t$/, ""); print }' ACTIVE_DISEASE_CD4_mpbs.bed > ACTIVE_DISEASE_CD4_mpbs.bed.tmp && mv ACTIVE_DISEASE_CD4_mpbs.bed.tmp ACTIVE_DISEASE_CD4_mpbs.bed
awk 'NF > 0 { gsub(/\t$/, ""); print }' ACTIVE_DISEASE_CD8_mpbs.bed > ACTIVE_DISEASE_CD8_mpbs.bed.tmp && mv ACTIVE_DISEASE_CD8_mpbs.bed.tmp ACTIVE_DISEASE_CD8_mpbs.bed