#!/bin/bash

for dir in merge_24564*/
do
  echo $dir
  cd $dir
  IFS='_' read -ra ADDR <<< "$dir"
  TMP_R=${ADDR[-1]}
  echo ${TMP_R:0:-1}
  efxtools.ccpred -i *predictions*.mtz --plot --title="r=${TMP_R}" --overall
#  efxtools.ccpred -i *predictions*.mtz --plot --title="r=0.9744" 
#  efxtools.ccpred -i gfp_predictions_*.mtz | tee ccpred.log
  cd ..
done
