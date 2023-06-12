# tpprwr

Maintenance of environments and containers for btx workflows.

## Installation

Create the `tpprwr` environment: 
```bash
conda env create -f tpprwr.yml
```

## Usage

See information under `conda/` or `docker/`.

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


