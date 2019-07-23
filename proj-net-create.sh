#!/bin/bash
export PROJ="xxx"
export DESC="xxx project"

echo "---> Creating project"
openstack project create --domain default \
    --description "${DESC}" --enable ${PROJ}
export ID=`openstack project show -f value -c id ${PROJ}`
echo
echo "Project id = ${ID}"
echo "---> Creating router = ${PROJ}_router"
openstack router create --project ${PROJ} \
    --ha --description "${PROJ} vxlan router" ${PROJ}_router

echo "---> Creating network vxlan network = ${PROJ}_net"
openstack network create --project ${PROJ} --mtu 1500 \
    --provider-network-type vxlan \
    --description "${PROJ} vxlan private" ${PROJ}_net

echo "---> Creating sub-network = ${PROJ}_subnet"
openstack subnet create --project ${PROJ} \
    --network ${PROJ}_net --subnet-range 192.168.1.0/24 \
    --dns-nameserver 193.136.75.129 --dns-nameserver 193.136.75.130 \
    --gateway 192.168.1.254 ${PROJ}_subnet

echo "---> Performing router-interface-add ${PROJ}_router ${PROJ}_subnet"
openstack router add subnet ${PROJ}_router ${PROJ}_subnet

echo "---> Performing router-gateway-set ${PROJ}_router public_net"
openstack router set --external-gateway public_net ${PROJ}_router

