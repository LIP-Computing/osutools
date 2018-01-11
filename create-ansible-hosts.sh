#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

IP_FILE=/tmp/ippub.txt

echo "Gathering all Public IPs"
openstack floating ip list -f value -c 'Floating IP Address' > ${IP_FILE}

echo "Printing all lines in the file - Public IPs"
while IFS= read -r var
do
  echo "$var"
done < "${IP_FILE}"

