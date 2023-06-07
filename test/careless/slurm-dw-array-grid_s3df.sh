#!/bin/bash
#SBATCH --job-name=pyp_dw
#SBATCH -p ampere # ffbgpuq # partition (queue)
#SBATCH --account lcls
#SBATCH --mem 32G # memory pool for all cores
#SBATCH -t 0-2:00 # time (D-HH:MM)
#SBATCH --gres=gpu:1
#SBATCH -o myoutput_%j.out
#SBATCH -e myoutput_%j.err

#  ** PROCESS GRID PARAMETERS **
PARAM_FILE=slurm_params.txt
#IL	MLPL    ITER    STDOF   PEF     rDW	RU
#MY_PARAMS=$(sed "${0}q;d" ${PARAM_FILE})
MY_PARAMS=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${PARAM_FILE})
#echo $MY_PARAMS

TMP=(${MY_PARAMS///})
echo "Parameters from slurm_params.txt: ${MY_PARAMS}"
IL="${TMP[0]}"
MLPL="${TMP[1]}"
ITER="${TMP[2]}"
STDOF="${TMP[3]}"
PEF="${TMP[4]}"
R="${TMP[5]}"
RU="${TMP[6]}"

MODE="poly"
DMIN=1.8
TEST_FRACTION=0.1
SEED=$RANDOM
BASENAME=pyp_1p6A_grid
HALF_REPEATS=0


INPUT_MTZS=(
    off_iso_uc.mtz
    2ms_iso_uc.mtz
)


DW_LIST=None,0
DWR_LIST=0.,${R}


source ~/miniconda3/etc/profile.d/conda.sh
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/n/home12/dhekstra/miniconda3/lib/
#conda activate careless-ampere
conda activate /sdf/group/lcls/ds/tools/conda_envs/careless

OUT=merge_${SLURM_JOB_ID}_${SEED}_${MODE}_grid_${SLURM_ARRAY_TASK_ID}
mkdir -p $OUT
cp $0 $OUT
cat $0 > $OUT/slurm_script


SECONDS=0
CARELESS_ARGS=(
#    --mc-samples=1         # default: 1
#    --learning-rate=0.001  # default: 0.001
#    --wilson-prior-b 18.0  # default: 0
    --separate-files
    --merge-half-datasets
#    --half-dataset-repeats=$HALF_REPEATS # must be >0 if --merge-half-datasets is on
#    --test-fraction=$TEST_FRACTION
    --image-layers=$IL
    --dmin=$DMIN
    --iterations=$ITER
    --positional-encoding-frequencies=$PEF
    --positional-encoding-keys="X,Y"
#    --mlp-width=12    # to restrain NN size when there are a lot of metadata, e.g. with positional encoding
    --mlp-layers=$MLPL
    --seed=$SEED
    --wavelength-key='Wavelength'
)
# WARNING: bash [] comparisons only work for integers
c=$(echo "$R > -0.01" | bc)
if [ $c = '1' ]
then
  CARELESS_ARGS+=(--double-wilson-parents=${DW_LIST}) 
  CARELESS_ARGS+=(--double-wilson-r=${DWR_LIST})
fi
if [ $IL -lt 0 ]
then
  CARELESS_ARGS+=( --disable-image-scales)
fi
if [ $RU -gt 0 ]
then
  CARELESS_ARGS+=( --refine-uncertainties)
fi
if [ $STDOF -gt 0 ]
then
  CARELESS_ARGS+=( --studentt-likelihood-dof=$STDOF)
fi
CARELESS_ARGS+=("X,Y,Wavelength,BATCH,dHKL,Hobs,Kobs,Lobs")

echo "Careless arguments: ${CARELESS_ARGS[@]}"
echo "Input MTZs: ${INPUT_MTZS[@]}"               > ./$OUT/inputs_params.log
echo "Args: $MODE ${CARELESS_ARGS[@]}"           >> ./$OUT/inputs_params.log
conda list > ./$OUT/conda_env_record.log
echo nvidia-smi > ./$OUT/nvidia-smi.log

careless $MODE ${CARELESS_ARGS[@]} ${INPUT_MTZS[@]} $OUT/$BASENAME


# --- Cleanup --- #
echo "Careless run complete."
#touch ./$OUT/inputs_params.log
mv myoutput*${SLURM_JOB_ID}* $OUT #DH added

DURATION=$SECONDS
MESSAGE="Job $SLURM_JOB_ID: Careless finished on $HOSTNAME in $(($DURATION / 60)) minutes."
echo $MESSAGE
