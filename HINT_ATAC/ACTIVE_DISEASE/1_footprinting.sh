#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/HINT_ATAC/footprint_log_active_disease.txt
#$ -N HINT_footprint_16                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 16

#$ -t 1-4
INDEX=$((SGE_TASK_ID))

module load functional_genomics/peak/rgt/1.0.2

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

beds_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_PsA_macs2_peaks"
bams_dir="/mnt/iusers01/jw01/x25633jb/scratch/MERGE_BAMS_PSA/downsampled"
out_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/HINT_ATAC/ACTIVE_DISEASE/footprinting"

# Define lists of BAM and BED files for each task
bed_files=("healthy_CD4_merged_filtered.bed" "healthy_CD8_merged_filtered.bed" "active_disease_CD4_merged_filtered.bed" "active_disease_CD8_merged_filtered.bed")
bam_files=("HEALTHY_CD4_merged_output_test.bam" "HEALTHY_CD8_merged_output_test.bam" "ACTIVE_DISEASE_CD4_merged_output_test.bam" "ACTIVE_DISEASE_CD8_merged_output_test.bam")

# Select the appropriate BAM and BED file based on the task ID (INDEX)
bam_file="${bams_dir}/${bam_files[INDEX-1]}"
bed_file="${beds_dir}/${bed_files[INDEX-1]}"

# Create output directory if it doesn't exist
mkdir -p ${out_dir}

# Run RGT-HINT footprinting for the selected task
rgt-hint footprinting --atac-seq --paired-end --organism=hg38 \
    --output-location=${out_dir} --output-prefix=${bam_files[INDEX-1]%_merged_output_test.bam} \
    ${bam_file} ${bed_file}