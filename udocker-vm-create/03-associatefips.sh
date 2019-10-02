#!/usr/bin/env bash

#
# Copyright 2019 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

# Change these variables
PROJ="lip"

while read -r line
do
    echo "---------------------------------------------------------------"
    SERVERID=$(echo $line | awk -F',' '{printf "%s", $1}' | tr -d '"')
    FIP=$(echo $line | awk -F',' '{printf "%s", $2}' | tr -d '"')
    echo "${SERVERID}, ${FIP}"
    openstack server add floating ip ${SERVERID} ${FIP}
    echo "      Associated server ${SERVERID} publicIP ${FIP}"
done < serverids

