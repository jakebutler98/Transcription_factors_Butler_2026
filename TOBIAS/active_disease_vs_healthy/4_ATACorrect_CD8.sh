#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/TOBIAS/CORRECT/active_disease_CD8.log
#$ -N myjob_8                      # Job name (output .o and .e files use this name
#$ -pe smp.pe 8

#$ -t 1-2
INDEX=$((SGE_TASK_ID))

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# load relevant modules
module load functional_genomics/utils/envs/py3817_r413
module load functional_genomics/peak/tobias/0.16.1

# select sample from index
SAMPLE=$(awk "NR==$INDEX" /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/metadata/active_disease_CD8_samples.txt)
filename="$SAMPLE"
# basename of sample
sample_name=$(echo "$filename" | sed 's/_merged_output_test\.bam//')
echo "running on sample" "$sample_name"

BAM=~/scratch/MERGE_BAMS_PSA/downsampled/"$SAMPLE" # Updated for active disease
GENOME=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/common_files/data/external/reference/hg38/Sequence/WholeGenomeFasta/genome.fa
BED=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_PsA_macs2_peaks/all_CD8_ACTIVE_DISEASE.bed # Updated for active disease
BLACKLIST=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/common_files/data/external/Blacklist/lists/hg38-blacklist.v2.bed
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/$sample_name

sleep $(($INDEX*20))

mkdir -p $OUTDIR

TOBIAS ATACorrect --bam $BAM \
    --genome $GENOME \
    --peaks $BED \
    --blacklist $BLACKLIST \
    --outdir $OUTDIR \
    --cores 8