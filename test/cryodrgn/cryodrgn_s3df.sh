#!/bin/bash

#SBATCH --job-name=cryodrgn-test
#SBATCH --output=cryodrgn-test.out
#SBATCH --error=cryodrgn-test.err
#SBATCH --time=0:15:00
#SBATCH --account lcls
#SBATCH --partition=ampere
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gpus a100:1
#SBATCH --cpus-per-task=16

nvidia-smi

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh
conda activate cryodrgn

cd ~
git clone https://github.com/zhonge/cryodrgn.git cryodrgn-test
cd cryodrgn-test/testing/
./quicktest.sh