#!/bin/bash

CURD=`pwd`

arrayZ=(
iana-if-type
ietf-yang-types@2013-07-15
ietf-interfaces@2014-05-08
bbf-yang-types
bbf-fastdsl
bbf-vdsl
)


for i in ${arrayZ[@]}; do
	echo "========= LOADING ${i}.yang =========="
	sudo sysrepoctl -i -g ${i}.yang --owner=darshana:darshana --permissions=777 -L 4 -s ${CURD}
	sudo sysrepoctl -t -m ${i}
done

sudo sysrepoctl -l

echo "========= LOADING startup configs =========="
sudo sysrepocfg --import=startup-data/vdsl_startup_data.xml --datastore=startup --format=xml bbf-vdsl
sudo sysrepocfg --import=startup-data/ietf_startup_data.xml --datastore=startup --format=xml ietf-interfaces

