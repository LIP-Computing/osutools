#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

# Change these variables
PROJ="PROJ_NAME"
USER="USERNAME"
DESC="User Description"
UPASS=${USER}
EMAIL=${USER}

openstack user create --domain default --project ${PROJ} --password "${UPASS}" \
    --email "${EMAIL}" --description "${DESC}" --enable ${USER}
