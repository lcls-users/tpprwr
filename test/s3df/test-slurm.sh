#!/bin/bash
#SBATCH --account=lcls
#SBATCH --partition=milano
#SBATCH --job-name=test-slurm
#SBATCH --output=logs/output-%j.txt --error=logs/output-%j.txt
#SBATCH --nodes=1 
#SBATCH --ntasks=2

#############################
# 1. Find singularity image #
#############################

singularity_images_repo="/sdf/group/lcls/ds/tools/singularity_images/"
if [ $# -ne 1 ]; then
	echo "Usage: sbatch test.slurm <image tag>"
	exit
fi
image_tag=$1
singularity_image="${singularity_images_repo}s3df_${image_tag}.sif"
if [ ! -f "${singularity_image}" ]; then
	echo "Error! Image not found: ${singularity_image}"
	exit
fi

####################
# 2. Run container #
####################
set -x
module load mpi/mpich-x86_64
mpirun -n 2 apptainer run -B /sdf ${singularity_image} python test.py
set +x
