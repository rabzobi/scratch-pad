#!/bin/bash

if [ -z $1 ] ; then
	echo "Provide test name"
	echo "Eg MonitoringLocationRestServiceIT#testListLimitAndSort"
	exit 1
fi

$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop

mvn -Dtest=$1 verify
