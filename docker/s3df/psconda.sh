#!/usr/bin/env bash

source /opt/anaconda/etc/profile.d/conda.sh
export HDF5_USE_FILE_LOCKING=FALSE
# needed for SRCF
export OPENBLAS_NUM_THREADS=1

export SIT_ROOT=/sdf/group/lcls/ds/ana/
export SIT_ARCH=x86_64-rhel7-gcc48-opt
export SIT_PSDM_DATA=/sdf/data/lcls/ds/
