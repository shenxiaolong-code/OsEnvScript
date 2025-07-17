#! /usr/bin/env bash

set -eo pipefail

: ${THIS_DIR:="$(dirname "$(readlink -f "$0")")"}

if [ -z ${LSB_HOSTS+x} ]; then
  : ${MAKE_J:=$(grep -c ^processor /proc/cpuinfo)}  
else
  : ${MAKE_J:=$(( $(echo ${LSB_HOSTS} | wc -w) * 2))}  
fi

echo "[Make] Utilizing ${MAKE_J} cores"

# echo -j ${MAKE_J} "${@}"
echo cmd : make install -j ${MAKE_J}
echo 
