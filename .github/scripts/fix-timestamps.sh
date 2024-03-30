#!/usr/bin/env sh

# This fix is from https://github.com/adityam/stochastic-control/tree/quarto/.github/scripts
# and is described at 
# https://github.com/quarto-dev/quarto-cli/discussions/5899#discussioncomment-7673260

git ls-tree -r --name-only HEAD | while read filename; do
  unixtime=$(git log -1 --format="%at" -- "${filename}")
  touchtime=$(date -d @$unixtime +'%Y%m%d%H%M.%S')
  touch -t ${touchtime} "${filename}"
done
