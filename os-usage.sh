#!/bin/bash


while IFS=' ' read -r start end
do
    echo "openstack usage list --start '$start' --end '$end'"
done < start-end.txt

