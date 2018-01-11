#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

IP_FILE=/tmp/ippub.txt
TMP_HOSTS=/tmp/hosts-tmp
ANS_HOST=/tmp/hosts

rm -f ${TMP_HOSTS} ${ANS_HOST}

echo "Gathering all Public IPs"

if [ ! -f ${IP_FILE} ]
then
  echo "--- Creating file with public IPs"
  openstack floating ip list -f value -c 'Floating IP Address' > ${IP_FILE}
fi

echo "Printing all lines in the file - Public IPs file ${IP_FILE}"
for var in $(cat ${IP_FILE})
do
  ssh -o ConnectTimeout=3 -o StrictHostKeyChecking=no -o BatchMode=yes ubuntu@${var} "uname -a"
  retval="$?"
  echo "---> $var ubuntu -- $retval"
  if [ $retval -eq 0 ]
  then
    echo "${var} ansible_connection=ssh ansible_user=ubuntu ansible_become=true" >> ${TMP_HOSTS}
  fi
  
  ssh -o ConnectTimeout=3 -o StrictHostKeyChecking=no -o BatchMode=yes centos@${var} "uname -a"
  retval="$?"
  echo "---> $var centos -- $retval"
  if [ $retval -eq 0 ]
  then
    echo "${var} ansible_connection=ssh ansible_user=centos ansible_become=true" >> ${TMP_HOSTS}
  fi

done

echo "[ubuntu]" >> ${ANS_HOST}
grep ubuntu ${TMP_HOSTS} >> ${ANS_HOST}
echo "[centos]" >> ${ANS_HOST}
grep centos ${TMP_HOSTS} >> ${ANS_HOST}


