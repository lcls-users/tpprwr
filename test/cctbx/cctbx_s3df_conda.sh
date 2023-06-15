#!/bin/bash
#SBATCH -A lcls
#SBATCH --partition=milano
#SBATCH --job-name=cctbx-test
#SBATCH --output=cctbx-test-%j.txt --error=cctbx-test-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=64

# cctbx.xfel Build instructions can be found here:
# https://github.com/cctbx/cctbx_project/tree/master/xfel/conda_envs

#
# and git-lfs is installed in the base environment.
source /sdf/group/lcls/ds/tools/cctbx/build/conda_setpaths.sh
conda update conda --yes
conda install git-lfs

# test cctbx
cd /sdf/group/lcls/ds/tools
if [ ! -d cctbx ]; then
  echo "STOP: /sdf/group/lcls/ds/tools/cctbx does not exist!"
  exit
fi

export SIT_DATA=/sdf/group/lcls/ds/ana/sw/conda1/inst/envs/ana-4.0.48-py3/data:/sdf/group/lcls/ds/ana/data/
export SIT_ROOT=$SIT_DATA
export SIT_PSDM_DATA=$SIT_DATA

cd cctbx/modules
git clone https://gitlab.com/cctbx/xfel_regression.git
git clone https://github.com/nksauter/LS49.git
git clone https://gitlab.com/cctbx/ls49_big_data.git
cd xfel_regression
git lfs install --local
git lfs pull
cd ../uc_metrics
git lfs install --local
git lfs pull
cd ../ls49_big_data
git lfs install --local
git lfs pull
cd ../../
mkdir test; cd test
libtbx.configure xfel_regression LS49 ls49_big_data
export OMP_NUM_THREADS=4
libtbx.run_tests_parallel module=uc_metrics module=simtbx module=xfel_regression module=LS49 nproc=64
