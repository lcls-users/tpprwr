# tpprwr

Maintenance of environments and containers for btx workflows.

## Installation

Create the `tpprwr` environment: 
```bash
conda env create -f tpprwr.yml
```

## Usage

### Manually maintained environments

#### S3DF

With the following `~/.condarc` file:
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

##### Careless

Running the following command: `cd install; sbatch careless-s3df-install.slurm`
will create `/sdf/group/lcls/ds/tools/conda_envs/careless`

To test, run `cd test/careless; sbatch --array=2,3 slurm-dw-array-grid_s3df.sh` 

### Automated

The following might work but manual intervention might be needed. No guarantee.

```bash
(env)[terminal]$ python create-container.py -h
...
```

Below is an example where the container is built with GitHub Actions:
```bash
python create-container.py -b yaml/psana1/ana-4.0.43-py3.yml -o ana-4.0.43-py3.yml -e -c -r fpoitevi -n ana -t 4.0.43-py3
git add .github/workflows/main.yaml
git add docker/ana-4.0.43-py3.yml
git tag -a ezbuild-ana-4.0.43-py3 -m "building ana-4.0.43-py3 and pushing to fpoitevi's DockerHub"
git push origin ezbuild-ana-4.0.43-py3
```


