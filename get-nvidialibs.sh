#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

OS_TYPE=`grep "^ID_LIKE=" /etc/os-release|cut -d'=' -f 2`
BIN_PREFIX="/usr/bin/"

if [ ${OS_TYPE} = 'debian' ]
then
  LIB64_PREFIX="/usr/lib/x86_64-linux-gnu/"
fi

if [[ ${OS_TYPE} =~ *rhel* ]]
then
  LIB64_PREFIX="/usr/lib64/"
fi

echo "LIB64_PREFIX= ${LIB64_PREFIX}"

