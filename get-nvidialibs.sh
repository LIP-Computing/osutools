#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

OS_TYPE=`grep "^ID_LIKE=" /etc/os-release|cut -d'=' -f 2`
BIN_PREFIX="/usr/bin/"

#OPT is the docker volume option
for vol in "/etc/vulkan/icd.d/nvidia_icd.json" "/etc/OpenCL/vendors/nvidia.icd"
do
  OPT="${OPT} -v ${vol}:${vol}"
done

if [ "${OS_TYPE}" = "debian" ]
then
  LIB64_PREFIX="/usr/lib/x86_64-linux-gnu/"
fi

if [[ ${OS_TYPE} == *rhel* ]]
then
  LIB64_PREFIX="/usr/lib64/"
fi

echo "LIB64_PREFIX=${LIB64_PREFIX}"

# List of nvidia bin to pass as volume

for vol in `find ${BIN_PREFIX} -name 'nvidia*'|grep -v container|grep -v docker|sort`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

for vol in `find ${LIB64_PREFIX} -name 'lib*GL*'|grep -v mesa|grep -v GLU`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

for vol in `find ${LIB64_PREFIX} -name 'libOpenCL*'`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

for vol in `find ${LIB64_PREFIX} -name 'libcuda*'`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

for vol in `find ${LIB64_PREFIX} -name 'libvdpau*'`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

for vol in `find ${LIB64_PREFIX} -name 'libnv*'|grep -v xorg|grep -v container`
do
  OPT="${OPT} -v ${vol}:${vol}"
done

echo ${OPT}

