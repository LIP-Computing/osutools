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
    SERVER=$(echo $line | awk -F',' '{printf "%s", $1}' | tr -d '"')
    IMGID=$(echo $line | awk -F',' '{printf "%s", $2}' | tr -d '"')

    echo "----------------------------------------------------------"
    FIP=`openstack floating ip create public_net -f value --project ${PROJ} -c floating_ip_address`
    echo "      Created the floating IP: ${FIP}"
    echo "${FIP}" >> hosts-cloud

    openstack volume create -f value --project ${PROJ} --size 100 \
        --image ${IMGID} -c id \
        ${SERVER}-vol

    VOLID=`openstack volume show ${SERVER}-vol -c id -f value`
    echo "      Created volume: ${VOLID}"
    echo "${VOLID},${SERVER},${FIP},${IMGID}" >> fips-volumes.csv

done < pu

