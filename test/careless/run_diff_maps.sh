#!/bin/bash
conda activate careless-dw

for dir in merge*DW_r*/
do
  echo $dir
  cd $dir
  IFS='_' read -ra ADDR <<< "$dir"
  TMP_R=${ADDR[-1]}
  echo ${TMP_R:0:-1}
  MTZOUT=pyp_${TMP_R:0:-1}.mtz
  efxtools.diffmap -on 'pyp-dw-test_1.mtz' 'F' 'SigF' -off 'pyp-dw-test_0.mtz' 'F' 'SigF' -r '../2PHY_off_mtz_refine__3.mtz' 'PHIF-model'
  mv diffmap.mtz $MTZOUT
  cp $MTZOUT ~/${MTZOUT}
  cd ..
done




