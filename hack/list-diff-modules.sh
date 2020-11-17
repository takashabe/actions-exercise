#!/usr/bin/env bash

set -uo pipefail

modules=$(find . -type f -name "go.mod")
echo $modules

diffs=()

# module directoryの変更があるものを探索する
for m in $modules; do
  m_dir=$(dirname $m)
  m_dir=${m_dir#./}

  result=0
  git diff origin/master --quiet --exit-code --relative=$m_dir || result=$?
  if [ $result = 1 ]; then
    diffs+=($m_dir)
  fi
done

echo ${diffs[@]}
