#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/logs/TOBIAS/BINDETECT/log_CD4_active_disease.txt
#$ -N myjob_8                      # Job name (output .o and .e files use this name
#$ -pe smp.pe 8
#$ -hold_jid 5598083


# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# load relevant modules
activate_project /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors
module load functional_genomics/peak/tobias/0.16.1

MOTIFS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/PsA_analysis/input/raw/JASPAR2024_combined_matrices_hs.txt
HEALTHY=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/HEALTHY_CD4/HEALTHY_CD4_footprint_scores.bw # Update for active disease
PATIENT=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/ACTIVE_DISEASE_CD4/ACTIVE_DISEASE_CD4_footprint_scores.bw # Update for active disease
GENOME=/mnt/jw01-aruk-home01/projects/functional_genomics/common_files/data/external/reference/Homo_sapiens/hg38/Sequence/WholeGenomeFasta/genome.fa
BED=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_PsA_macs2_peaks/all_CD4_ACTIVE_DISEASE_annotated.bed # Updated for active disease
PEAK_HEADER=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/clean/merged_PsA_macs2_peaks/all_CD4_ACTIVE_DISEASE_annotated_header.txt # Update for active disease
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/ACTIVE_DISEASE/CD4_BINDetect # Update for active disease

TOBIAS BINDetect \
    --motifs $MOTIFS \
    --signals $HEALTHY $PATIENT \
    --genome $GENOME \
    --peaks $BED \
    --peak_header $PEAK_HEADER \
    --outdir $OUTDIR \
    --cond_names HEALTHY_CD4 ACTIVE_DISEASE_CD4 \
    --cores 8
