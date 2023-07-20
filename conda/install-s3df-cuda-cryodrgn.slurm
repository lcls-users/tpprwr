#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=ampere
#SBATCH --job-name=cryodrgn-install
#SBATCH --output=cryodrgn-install-%j.txt --error=cryodrgn-install-%j.txt
#SBATCH --ntasks=1
#SBATCH --gpus a100:1
#SBATCH --cpus-per-task=16

nvidia-smi

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh

conda create --name cryodrgn python=3.9
conda activate cryodrgn

conda install pytorch cudatoolkit=11.7 -c pytorch

pip install --upgrade pip
pip install cryodrgn

cryodrgn --version