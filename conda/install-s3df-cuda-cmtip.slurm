#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=ampere
#SBATCH --job-name=cmtip-cuda-install
#SBATCH --output=cmtip-cuda-install-%j.txt --error=cmtip-cuda-install-%j.txt
#SBATCH --ntasks=1
#SBATCH --gpus a100:1
#SBATCH --cpus-per-task=16

nvidia-smi

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh

conda create --clone $CONDA_DEFAULT_ENV --prefix /sdf/group/lcls/ds/tools/conda_envs/cmtip-cuda --yes --experimental-solver=libmamba
conda activate cmtip-cuda
conda install --experimental-solver=libmamba mpi=1.0=mpich mpich=3.3 mpi4py cupy cudatoolkit=11.7 --yes
# TODO: still missing cufinnft and pycuda. Cupy might help with skopi.
pip install --upgrade pip
pip install git+https://github.com/apeck12/cmtip --upgrade
