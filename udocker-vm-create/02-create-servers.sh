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
    echo "----------------------------------------------------------"
    VOLID=$(echo $line | awk -F',' '{printf "%s", $1}' | tr -d '"')
    SERVER=$(echo $line | awk -F',' '{printf "%s", $2}' | tr -d '"')
    FIP=$(echo $line | awk -F',' '{printf "%s", $3}' | tr -d '"')
    IMGID=$(echo $line | awk -F',' '{printf "%s", $4}' | tr -d '"')
    echo "${VOLID}, ${SERVER}, ${FIP}, ${IMGID}"

    openstack server create --flavor svc1.m --key-name mdavid \
        --network tutorial_net --volume ${VOLID} ${SERVER}

    SERVERID=`openstack server show ${SERVER} -f value -c id`
    echo "      Created server ${SERVERID}"
    echo "${SERVERID},${FIP}" >> serverids

done < fips-volumes.csv

