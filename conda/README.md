# `conda` install recipes

We maintain SLURM scripts to install software in their associated conda environment at a given facility (S3DF, NERSC, ...), with or without CUDA support. 
The chosen nomenclature for the install scripts is: `install-<s3df,nersc,...>-<base,cuda>-<none,software name>.slurm`

# Installation at S3DF

We list below the softwares currently maintained in conda environments at S3DF.

## Careless

| Step         | Command                                                                   | Comment                                                                                                                                                        | 
|--------------|---------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Installation | `sbatch install-s3df-cuda-careless.slurm`                                 | *This will create `/sdf/group/lcls/ds/tools/conda_envs/careless`<br> unless you set a different `envs_dirs` (see additional remarks below).* |
| Usage        | `source ~/miniconda3/etc/profile.d/conda.sh`<br>`conda activate careless` | *This assumes a local install of Miniconda*                                                                                                                    |
| Test         | `cd tpprwr/test/careless`<br>`sbatch --array=2,3 slurm-dw-array-grid_s3df.sh` |                                                                                                                                                                |

## cmtip

*WIP: To make use of GPUs, the reconstruction script needs pycuda, and we will use a container approach for that (coming up).*

| Step         | Command                                                                                                  | Comment                                                                                                                                   | 
|--------------|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| Installation | `sbatch install-s3df-cuda-cmtip.slurm`                                                                   | *This will create `/sdf/group/lcls/ds/tools/conda_envs/cmtip`* |
| Usage        | `source /sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh`<br>`conda activate cmtip`                |                                                                                               |
| Test         | `cd tpprwr/test/cmtip`<br>`sbatch cmtip_simulation_s3df.sh`<br>`sbatch cmtip_reconstruction_s3df.sh` |                                                                                                                                           |



## Additional remarks

We suggest to create the following `~/.condarc` file:
```conda
channels:
  - defaults
  - anaconda
  - conda-forge
  - lcls-i
envs_dirs:
  - /sdf/group/lcls/ds/tools/conda_envs
pkgs_dirs:
  - /sdf/group/lcls/ds/tools/conda_pkgs
```


