#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

OS_TYPE=`grep "^ID_LIKE=" /etc/os-release|cut -d'=' -f 2`
BIN_PREFIX="/usr/bin/"

#OPT is the docker volume option
#for vol in "/etc/vulkan/icd.d/nvidia_icd.json" "/etc/OpenCL/vendors/nvidia.icd"
for vol in "/etc/OpenCL/vendors/nvidia.icd"
do
  OPT="${OPT} -v ${vol}:${vol}"
done

# LIB64_PREFIX for the host system

if [ "${OS_TYPE}" = "debian" ]
then
  LIB64_PREFIX="/usr/lib/x86_64-linux-gnu/"
fi

if [[ ${OS_TYPE} == *rhel* ]]
then
  LIB64_PREFIX="/usr/lib64/"
fi

#echo "LIB64_PREFIX=${LIB64_PREFIX}"

# LIB64_image for the docker image
#LIB64_image="/usr/lib/x86_64-linux-gnu/"
LIB64_image="/usr/lib64/"

# List of nvidia bin to pass as volume
echo "-----"
binlist="["
cd ${BIN_PREFIX}
for vol in `find . -name 'nvidia*' -printf "%P\n" |grep -v container|grep -v docker|sort`
do
  OPT="${OPT} -v ${vol}:${vol}"
  binlist="${binlist}'${vol}', "
done
binlist="${binlist}]"
echo $binlist



cd ${LIB64_PREFIX}
echo "-----"
liblist="["
for vol1 in `find . -name 'lib*GL*' -printf "%P\n" |sort |grep -v mesa|grep -v GLU`
do
  vol=`echo $vol1|cut -d "/" -f 2-`
  OPT="${OPT} -v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
  vol2=`echo $vol1|cut -d "." -f 1`
  liblist="${liblist}'${vol2}', "
#  echo "-v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
done

for vol1 in `find . -name 'libOpenCL*' -printf "%P\n" |sort`
do
  vol=`echo $vol1|cut -d "/" -f 2-`
  OPT="${OPT} -v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
  vol2=`echo $vol1|cut -d "." -f 1`
  liblist="${liblist}'${vol2}', "
#  echo "-v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
done

for vol1 in `find . -name 'libcuda*' -printf "%P\n" |sort`
do
  vol=`echo $vol1|cut -d "/" -f 2-`
  OPT="${OPT} -v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
  vol2=`echo $vol1|cut -d "." -f 1`
  liblist="${liblist}'${vol2}', "
#  echo "-v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
done

for vol1 in `find . -name 'libvdpau*' -printf "%P\n" |sort`
do
  vol=`echo $vol1|cut -d "/" -f 2-`
  OPT="${OPT} -v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
  vol2=`echo $vol1|cut -d "." -f 1`
  liblist="${liblist}'${vol2}', "
#  echo "-v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
done

for vol1 in `find . -name 'libnv*' -printf "%P\n" |sort|grep -v xorg|grep -v container`
do
  vol=`echo $vol1|cut -d "/" -f 2-`
  OPT="${OPT} -v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
  vol2=`echo $vol1|cut -d "." -f 1`
  liblist="${liblist}'${vol2}', "
#  echo "-v ${LIB64_PREFIX}${vol}:${LIB64_image}${vol}"
done
liblist="${liblist}]"
echo $liblist

echo "-----"

echo ${OPT}
#export OPT=${OPT}

