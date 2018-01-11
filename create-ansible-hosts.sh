#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

IP_FILE=/tmp/ippub.txt
ANS_HOST=/tmp/hosts

rm -f ${ANS_HOST}

echo "Gathering all Public IPs"

if [ ! -f ${IP_FILE} ]
then
  openstack floating ip list -f value -c 'Floating IP Address' > ${IP_FILE}
fi

echo "Printing all lines in the file - Public IPs"
while IFS= read -r var
do
  echo "---> $var"
  if ssh -o ConnectTimeout=3 -o StrictHostKeyChecking=no -o BatchMode=yes ubuntu@${var} "uname -a"
  then
    echo "${var} ansible_connection=ssh ansible_user=ubuntu ansible_become=true" >> ${ANS_HOST}
  fi
  
  if ssh -o ConnectTimeout=3 -o StrictHostKeyChecking=no -o BatchMode=yes centos@${var} "uname -a"
  then
    echo "${var} ansible_connection=ssh ansible_user=centos ansible_become=true" >> ${ANS_HOST}
  fi

done < "${IP_FILE}"

