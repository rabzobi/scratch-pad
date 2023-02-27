#!/bin/bash

ACTION=" clean install -P rapid-build -DskipTests=true "

MODULES="parent-pom shared-lib alarm minion-gateway minion-gateway-grpc-proxy minion rest-server inventory notifications metrics-processor events datachoices"


for MODULE in $MODULES ; do
	START=$SECONDS
	echo -n "Building $MODULE"
	mvn $ACTION -l $MODULE.log -f $MODULE
	CODE=$?
	echo " $(($SECONDS - $START))s"
	if [ $CODE -ne 0 ]; then
		cat $MODULE.log
		rm -f MODULE.log
		exit 1
	fi
	rm -f MODULE.log
done

echo "Finished in $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds."
