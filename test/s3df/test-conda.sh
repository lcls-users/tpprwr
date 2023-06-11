#!/bin/bash
#SBATCH --account=lcls
#SBATCH --partition=milano
#SBATCH --job-name=test-conda
#SBATCH --output=logs/output-%j.txt --error=logs/output-%j.txt
#SBATCH --nodes=1 
#SBATCH --ntasks=2

set -x
module load mpi/mpich-x86_64
source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh
conda activate /sdf/group/lcls/ds/tools/conda_envs/base-mpich
mpirun -n 2 python test.py
set +x
