#!/usr/bin/env bash

set -eo pipefail

# main params $1=url
function main() {
  src=$1

  declare -A api_svc
  api_svc["foo-bar"]="API_URL1"
  api_svc["bar-foo"]="API_URL2"

  for s in ${!api_svc[@]}; do
    if [ `echo $src | grep $s` ]; then
      elm="{\"name\":\"${api_svc[$s]}\",\"url\":\"$src\"},"
      echo $elm
      return 0
    fi
  done
}

if [ $# -ne 1 ]; then
  echo "usage: $0 <URL_LIST_FILE>" 1>&2
  exit 1
fi
src=`cat $1`

ret='['
for i in $src; do
  ret=$ret`main $i`
done
ret=${ret%,}
ret="${ret}]"

echo $ret
