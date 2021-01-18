#!/usr/bin/env bash

set -euo pipefail

body="/preview env=dev"
env=$(echo $body | sed -e 's/\/preview env=\(.*\)/\1/')
echo $env
