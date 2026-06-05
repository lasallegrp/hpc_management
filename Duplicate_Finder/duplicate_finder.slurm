#!/bin/bash
#SBATCH --job-name=duplicate_finder
#SBATCH --mail-user=gekuodza@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --time=3-00:00:00
#SBATCH --partition=high
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --account=genome-center-grp
#SBATCH --output=/quobyte/lasallegrp/projects/hpc_management/Duplicate_Finder/logs/duplicate_finder.j%j.out
#SBATCH --error=/quobyte/lasallegrp/projects/hpc_management/Duplicate_Finder/logs/duplicate_finder.j%j.err
#SBATCH --chdir=/quobyte/lasallegrp/projects/hpc_management/Duplicate_Finder

set -o nounset
set -o errexit
set -o pipefail
set -x

START_TIME=$(date '+%Y-%m-%d %H:%M:%S %Z')
echo "========================================"
echo "Job started at: $START_TIME"
echo "SLURM job ID: ${SLURM_JOB_ID}"
echo "Running on node(s): ${SLURM_NODELIST}"
echo "========================================"

python3 duplicate_finder.py \
  /quobyte/lasallegrp/ \
  --min 10M \
  --bytes 4096 \
  --skip anaconda \
  --hidden \
  --duplicates \
  --denied \
  > /quobyte/lasallegrp/projects/hpc_management/Duplicate_Finder/Runs/2026_06_06_duplicate_files_results.txt

env | grep SLURM
scontrol show job ${SLURM_JOB_ID}
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch