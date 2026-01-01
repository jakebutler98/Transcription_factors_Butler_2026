#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/TOBIAS/FOOTPRINT/log_active_disease.txt
#$ -N myjob_8                      # Job name (output .o and .e files use this name
#$ -pe smp.pe 8

#$ -t 1-2
INDEX=$((SGE_TASK_ID))

# load relevant modules
activate_project /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors
module load functional_genomics/peak/tobias/0.16.1

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# select sample from index
SAMPLE=$(awk "NR==$INDEX" /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/metadata/active_disease_CD4_samples.txt)
filename="$SAMPLE"
# basename of sample
sample_name=$(echo "$filename" | sed 's/_merged_output_test\.bam//')
echo "running on sample" "$sample_name"

CORRECTED_BW=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/$sample_name/"$sample_name"_merged_output_test_corrected.bw
REGIONS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_PsA_macs2_peaks/all_CD4_ACTIVE_DISEASE.bed # Updated for active disease
OUTPUT=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/$sample_name/"$sample_name"_footprint_scores.bw
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/$sample_name/
sleep $(($INDEX*20))

echo "running on sample $SAMPLE"
mkdir -p $OUTDIR

TOBIAS FootprintScores \
    --signal $CORRECTED_BW \
    --regions $REGIONS \
    --output $OUTPUT \
    --cores 8
