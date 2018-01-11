#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

IP_FILE=/tmp/ippub.txt

openstack floating ip list -f value -c 'Floating IP Address' > ${IP_FILE}




