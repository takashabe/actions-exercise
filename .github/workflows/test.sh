#!/usr/bin/env bash

set -euo pipefail
set +e

PRE_RELEASE_BRANCH='pre-release'

out=$(git branch -a | grep -E "remotes/origin/$PRE_RELEASE_BRANCH$")
if [ $? -ne 0 ]; then
  # 既に作成済みであればスキップ
  echo "skip create pre-release branch"
  exit 0
fi
echo $out
