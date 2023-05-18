#!/bin/bash
#SBATCH --account=lcls
#SBATCH --partition=milano
#SBATCH --job-name=test
#SBATCH --output=output-%j.txt --error=output-%j.txt
#SBATCH --nodes=1 --ntasks=1
#SBATCH --cpus-per-task=1
singularity exec -B /sdf /sdf/group/lcls/ds/tools/singularity_images/s3df_latest.sif echo "test"
