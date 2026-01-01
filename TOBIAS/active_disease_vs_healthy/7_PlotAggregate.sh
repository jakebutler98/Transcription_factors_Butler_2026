#!/bin/bash --login
#SBATCH -J PlotAggregate                 # Job name
#SBATCH -p multicore                     # Partition
#SBATCH -n 1                             # Number of tasks (usually 1 for array jobs)
#SBATCH -c 2                             # CPUs per task
#SBATCH -t 0:10:00                            # Time (minutes)
#SBATCH -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotAggregate/logs/%x-%A_%a.log
#SBATCH -e /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotAggregate/logs/%x-%A_%a.log

activate_project /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors

module load functional_genomics/peak/tobias/0.16.1

FOSJUNB="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/ACTIVE_DISEASE/CD8_BINDetect/SP2_MA0516.3/beds/SP2_MA0516.3_all.bed"
FOSJUNB_bound_HEALTHY="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/ACTIVE_DISEASE/CD8_BINDetect/SP2_MA0516.3/beds/SP2_MA0516.3_HEALTHY_CD8_bound.bed"
FOSJUNB_bound_ACTIVE_DISEASE="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/ACTIVE_DISEASE/CD8_BINDetect/SP2_MA0516.3/beds/SP2_MA0516.3_ACTIVE_DISEASE_CD8_bound.bed"


ACTIVE_DISEASE_SIGNAL="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/ACTIVE_DISEASE_CD8/ACTIVE_DISEASE_CD8_merged_output_test_corrected.bw"
HEALTHY_SIGNAL="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/HEALTHY_CD8/HEALTHY_CD8_merged_output_test_corrected.bw"

OUTDIR="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotAggregate/CD8"

mkdir -p $OUTDIR

TOBIAS PlotAggregate --TFBS $FOSJUNB \
    --signals $ACTIVE_DISEASE_SIGNAL $HEALTHY_SIGNAL \
    --output $OUTDIR/SP2_footprint_comparison_ACTIVE_DISEASE_vs_HEALTHY.pdf \
    --share_y both --plot_boundaries --signal_on_x \
    --signal-labels "Active Disease" "Healthy" \
    --share-y signals --plot-boundaries --log-transform