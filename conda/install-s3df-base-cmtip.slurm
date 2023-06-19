#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=milano
#SBATCH --job-name=cmtip-cpu-install
#SBATCH --output=cmtip-cpu-install-%j.txt --error=cmtip-cpu-install-%j.txt
#SBATCH --ntasks=1

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh

conda create --clone $CONDA_DEFAULT_ENV --prefix /sdf/group/lcls/ds/tools/conda_envs/cmtip-cpu --yes --experimental-solver=libmamba
conda activate cmtip-cpu
conda install --experimental-solver=libmamba mpi=1.0=mpich mpich=3.3 mpi4py --yes
pip install --upgrade pip
pip install git+https://github.com/apeck12/cmtip --upgrade
