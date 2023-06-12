#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=milano
#SBATCH --job-name=mpich-install
#SBATCH --output=mpich-install-%j.txt --error=mpich-install-%j.txt
#SBATCH --ntasks=1

source ~/miniconda3/etc/profile.d/conda.sh
/usr/bin/which conda
conda --version
conda update conda --yes
conda --version
conda create --name base-mpich mamba python=3 --yes
conda activate base-mpich
mamba install mpi=1.0=mpich mpich=3.3 mpi4py --yes

