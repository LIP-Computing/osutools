#!/usr/bin/env bash

#
# Copyright 2017 LIP
#
# Author: Mario David <mariojmdavid@gmail.com>
#

for i in `openstack floating ip list -f value |grep None|cut -f1 -d ' '`
do
  echo $i
  openstack floating ip delete $i
done
