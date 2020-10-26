#!/usr/bin/env bash

set -uo pipefail

branch=$1

max=3
for i in {1..$max}; do
  echo "[retryable-push.sh] trying $i"

  git push origin $branch
  if [ $? == 0 ]; then
    exit 0
  fi

  git pull --rebase origin $branch
  sleep 1
done
