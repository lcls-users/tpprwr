#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=milano
#SBATCH --job-name=cctbx-install
#SBATCH --output=cctbx-install-%j.txt --error=cctbx-install-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=48

# cctbx.xfel Build instructions can be found here:
# https://github.com/cctbx/cctbx_project/tree/master/xfel/conda_envs

# make sure conda is up to date
# and mamba is installed in the base environment.
source ~/miniconda3/etc/profile.d/conda.sh
conda update conda --yes
conda install mamba

# install cctbx
cd /sdf/group/lcls/ds/tools
if [ -d cctbx ]; then
  echo "STOP: /sdf/group/lcls/ds/tools/cctbx already exists!"
  exit

mkdir cctbx; cd cctbx
wget https://raw.githubusercontent.com/cctbx/cctbx_project/master/libtbx/auto_build/bootstrap.py
wget https://raw.githubusercontent.com/cctbx/cctbx_project/master/xfel/conda_envs/psana_environment.yml
mamba env create -f psana_environment.yml -p $PWD/conda_base
conda activate `pwd`/conda_base
python bootstrap.py --builder=xfel --use-conda=$PWD/conda_base --nproc=48 \
  --python=39 --no-boost-src hot update build
echo $PWD/build/conda_setpaths.sh