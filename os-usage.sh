#!/bin/bash


while IFS=' ' read -r start end
do
    echo "openstack usage list --start '$start' --end '$end' -f csv -c Project -c Servers"
    openstack usage list --start "$start" --end "$end" -f csv -c Project -c Servers > servers-$start.csv
    openstack usage list --start "$start" --end "$end" -f csv -c Project -c "CPU Hours" > cpus-$start.csv
done < start-end.txt

