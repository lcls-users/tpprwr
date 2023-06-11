#!/bin/bash

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh
conda activate /sdf/group/lcls/ds/tools/conda_envs/cmtip-cuda

work_dir=${PWD}
mkdir -p reconstruction

code_dir=$(python -c "import site; print(''.join(site.getsitepackages()))")


for vnum in `seq 0 9`
do

cat >> temp_${vnum}.sh <<EOF
#!/bin/bash

#SBATCH --job-name=cmtip-rec_${vnum}
#SBATCH --output=cmtip-rec_${vnum}.out
#SBATCH --error=cmtip-rec_${vnum}.err

#SBATCH --time=15:00:00
#SBATCH --account lcls
#SBATCH -p milano
#SBATCH --ntasks=8
#SBATCH --mem=196G

module load mpi/mpich-x86_64

source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh

conda activate /sdf/group/lcls/ds/tools/conda_envs/cmtip-cuda

cd ${work_dir}/reconstruction

mpirun -n 8 python ${code_dir}/cmtip/reconstruct_mpi.py -i ${work_dir}/simulation/2cexa_sim.h5 -t 10000 -b 4 -aw 8 -2 -ar 20000 60000 120000 -ab 4 12 20 -m 61 71 81 -r 6 4 3 -n 8 -o rec_${vnum}

EOF

sbatch temp_${vnum}.sh
done
