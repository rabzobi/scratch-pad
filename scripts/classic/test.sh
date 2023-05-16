#!/bin/bash

if [ -z $1 ] ; then
	echo "Provide test name"
	echo "Eg MonitoringLocationRestServiceIT#testListLimitAndSortLong"
	exit 1
fi

kill-nms.sh

mvn clean compile -Dtest=$1 verify
