#!/bin/bash

#SBATCH --job-name=cmtip-sim
#SBATCH --output=cmtip-sim.out
#SBATCH --error=cmtip-sim.err
#SBATCH --time=0:15:00
#SBATCH --account lcls
#SBATCH --partition=ampere
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gpus a100:1
#SBATCH --cpus-per-task=16

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh
conda activate /sdf/group/lcls/ds/tools/conda_envs/cmtip

# USE_CUPY needs to be set for Skopi to use GPUs
export USE_CUPY=1

work_dir=${PWD}
mkdir -p simulation

code_dir=$(python -c "import site; print(''.join(site.getsitepackages()))")

cd ${work_dir}/simulation


#python /sdf/home/a/apeck/exafel/milestone/simulate_beam_jitter.py -b /sdf/home/a/apeck/cmtip/examples/input/amo86615.beam -p /scratch/apeck/cmtip_dev3/pdbs/2cex_a.pdb -d pnccd /sdf/home/a/apeck/skopi/examples/input/lcls/amo86615/PNCCD::CalibV1/Camp.0:pnCCD.1/geometry/0-end.data 0.04 -n 100 -o 2cexa_sim.h5 -q -s 100 -bj 0.5
python ${code_dir}/cmtip/simulate.py -b ${work_dir}/amo86615/amo86615.beam -p ${work_dir}/2cex_a.pdb -d pnccd ${work_dir}/amo86615/PNCCD::CalibV1/Camp.0:pnCCD.1/geometry/0-end.data 0.04 -n 100 -o 2cexa_sim.h5 -q -s 100

