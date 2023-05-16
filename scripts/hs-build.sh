#!/bin/bash
#
# Author: Rob
# Date: 2023-03-01
#

if [ -z $1 ] ; then
	echo "Usage: $0 [option]"
	echo "Option can be: clean, shared-lib, build"
	echo " clean      : clean all targets"
	echo " shared-lib : build only shared-lib"
	echo " all        : build all"
	exit 1
fi

if [ `pwd | rev | cut -f1 -d/ | rev` != "horizon-stream-project" ] ; then
	echo "ERROR: Working directory `pwd` incorrect"
	exit 1
fi

if [ $1 = "clean" ] ; then
	ACTION="clean"
fi

if [ $1 = "all" ] ; then
	ACTION="clean install -P rapid-build -DskipTests=true"
fi


if [ $1 = "shared-lib" ] ; then
	mvn clean install -P rapid-build -DskipTests=true -f shared-lib
	exit
fi


MODULES="parent-pom shared-lib alert minion-gateway minion-certificate-manager minion-certificate-verifier minion rest-server inventory notifications metrics-processor events datachoices"

echo "ACTION = $ACTION"
echo "MODULES = $MODULES"

for MODULE in $MODULES ; do
	START=$SECONDS
	echo -n "Building $MODULE"
	mvn $ACTION -l $MODULE.log -f $MODULE
	CODE=$?
	echo " $(($SECONDS - $START))s"
	if [ $CODE -ne 0 ]; then
		cat $MODULE.log
		rm -f $MODULE.log
		exit 1
	fi
	rm -f $MODULE.log
done

echo "Finished in $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds."
