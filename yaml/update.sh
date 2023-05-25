#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Usage error: $0 <s3df/pcds>"
  exit
fi

location=$1

if [ $location == "s3df" ]; then
	psconda_script="/sdf/group/lcls/ds/ana/sw/conda1/manage/bin/psconda.sh"
elif [ $location == "pcds" ]; then
	psconda_script="/reg/g/psdm/etc/psconda.sh"
else
	echo "Error. Location $location not recognized."
	exit
fi

source $psconda_script

conda env export > ${location}_${CONDA_DEFAULT_ENV}.yaml

echo "Done updating ${location}_${CONDA_DEFAULT_ENV}.yaml"
