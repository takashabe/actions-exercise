#!/bin/env bash

set -eu

gh pr list --head main

exists_pr=$(gh pr list --head main)
if [ -z $exists_pr ]; then
  echo 'true'
else
  echo 'false'
fi
