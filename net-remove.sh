#!/bin/bash
export PROJ="xxx"

echo "---> Performing router unset ${PROJ}_router public_net"
openstack router unset --external-gateway ${PROJ}_router

echo "---> Performing router remove ${PROJ}_router ${PROJ}_subnet"
openstack router remove subnet ${PROJ}_router ${PROJ}_subnet

echo "---> Remove sub-network = ${PROJ}_subnet"
openstack subnet delete ${PROJ}_subnet

echo "---> Remove network vxlan network = ${PROJ}_net"
openstack network delete ${PROJ}_net

echo "---> Delete router = ${PROJ}_router"
openstack router delete ${PROJ}_router

