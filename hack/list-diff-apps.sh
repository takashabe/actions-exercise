#!/usr/bin/env bash

set -uo pipefail

search_dir="^src/"
targets=$(git diff origin/master --name-only | grep -E "$search_dir" | grep / ) #| awk 'BEGIN {FS="/"} {print $1"/"$2}' | uniq)

apps=()
for t in $targets; do
  # アプリケーションルートを探す. 対象が存在しなければskip
  if [ ! $(find $t -type f -name "go.mod") ]; then
    continue
  fi
  apps+=($t)
done

echo ${apps[@]}
