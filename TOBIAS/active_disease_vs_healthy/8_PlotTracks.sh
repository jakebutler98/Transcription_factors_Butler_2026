#!/bin/bash --login
#SBATCH -J PlotTracks                 # Job name
#SBATCH -p multicore                     # Partition
#SBATCH -n 1                             # Number of tasks (usually 1 for array jobs)
#SBATCH -c 2                             # CPUs per task
#SBATCH -t 00:10:00                            # Time (minutes)
#SBATCH -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotTracks/logs/%x-%A_%a.log
#SBATCH -e /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotTracks/logs/%x-%A_%a.log

activate_project /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors

module load functional_genomics/peak/tobias/0.16.1

cd /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotTracks

CD8_AD_BW="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/ACTIVE_DISEASE_CD8/ACTIVE_DISEASE_CD8_merged_output_test_corrected.bw"
CD8_H_BW="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/CORRECTED/ACTIVE_DISEASE/HEALTHY_CD8/HEALTHY_CD8_merged_output_test_corrected.bw"
CD8_AD_footprints="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/ACTIVE_DISEASE_CD8/ACTIVE_DISEASE_CD8_footprint_scores.bw"
CD8_H_footprints="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/FOOTPRINTSCORES/ACTIVE_DISEASE/HEALTHY_CD8/HEALTHY_CD8_footprint_scores.bw"
REGIONS="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/PlotTracks/FOSJUN.bed"
GENES="/mnt/jw01-aruk-home01/projects/functional_genomics/common_files/data/external/reference/Homo_sapiens/hg38/Annotation/Genes/genes.gtf"

E2F8_sites="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/transcription_factors/analyses/PsA_TFs/data/output/TOBIAS/ACTIVE_DISEASE/CD8_BINDetect/FOSJUN_MA1126.1/beds/FOSJUN_MA1126.1_all.bed"

#$ TOBIAS PlotTracks --bigwigs test_data/*cell_corrected.bw --bigwigs test_data/*cell_footprints.bw --regions test_data/plot_regions.bed --sites test_data/binding_sites.bed --highlight test_data/binding_sites.bed --gtf test_data/genes.gtf --colors red darkblue red darkblue


TOBIAS PlotTracks \
    --bigwigs $CD8_H_footprints --bigwigs $CD8_AD_footprints \
    --regions $REGIONS --sites $E2F8_sites --highlight $E2F8_sites \
    --gtf $GENES --colors red darkblue red darkblue \
    --labels "Active Disease" "Healthy" 