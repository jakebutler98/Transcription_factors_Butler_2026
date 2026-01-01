#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/HINT_ATAC/differential_log_active_disease.txt
#$ -N HINT_differentail_8  # Job name (output .o and .e files use this name)
#$ -pe smp.pe 8
#$ -t 1-2               # Adjust to run the script twice, once for CD4 and once for CD8
#$ -hold_jid 5601420

# Set the index to select the correct files for CD4 or CD8
INDEX=$((SGE_TASK_ID))

module load functional_genomics/peak/rgt/1.0.2

# Inform the app how many cores we requested for our job.
export OMP_NUM_THREADS=$NSLOTS

# Define directories
differential_predictions_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/HINT_ATAC/ACTIVE_DISEASE/differential"
mpbs_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/HINT_ATAC/ACTIVE_DISEASE/matching/mid_stringent"
bam_dir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_bams"

# Define conditions
conditions="HEALTHY,ACITVE_DISEASE"

# Select MPBS and BAM files based on the job array index
if [ "$INDEX" -eq 1 ]; then
    # CD4 comparison
    mpbs_files="${mpbs_dir}/HEALTHY_CD4_mpbs.bed,${mpbs_dir}/ACTIVE_DISEASE_CD4_mpbs.bed"
    bams_files="${bam_dir}/HEALTHY_CD4_merged_output_test.bam,${bam_dir}/ACTIVE_DISEASE_CD4_merged_output_test.bam"
    comparison_type="CD4"
elif [ "$INDEX" -eq 2 ]; then
    # CD8 comparison
    mpbs_files="${mpbs_dir}/HEALTHY_CD8_mpbs.bed,${mpbs_dir}/ACTIVE_DISEASE_CD8_mpbs.bed"
    bams_files="${bam_dir}/HEALTHY_CD8_merged_output_test.bam,${bam_dir}/ACTIVE_DISEASE_CD8_merged_output_test.bam"
    comparison_type="CD8"
else
    echo "Invalid INDEX value. Please set the job array range to cover only the required comparisons."
    exit 1
fi

# Run the differential footprinting analysis for the specified comparison
rgt-hint differential \
    --organism=hg38 \
    --bc \
    --nc 8 \
    --mpbs-files=${mpbs_files} \
    --reads-files=${bams_files} \
    --conditions=${conditions} \
    --output-location=${differential_predictions_dir}/${comparison_type}
