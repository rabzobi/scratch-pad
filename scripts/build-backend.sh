#!/bin/bash

FUNC=$1
APP=$FUNC-functionapp

if [ -z $FUNC ] ; then
	echo "Usage: $0 [internal|external|portal]"
	exit 1
fi

if [ ! -d $APP ] ; then
	echo "$APP directory does not exist. You must be in the root of the repod"
	exit 1
fi

if [ -z $CLOUDSUFFIX ] ; then
	echo "CLOUDSUFFIX not set"
	exit 1
fi


echo "Compiling with CLOUDSUFFIX=$CLOUDSUFFIX"
START=`date +"%s"`
mvn --quiet -T 4 package -pl $APP -am -Dkotlin.compiler.incremental=true -DskipTests &
PID=$! 

echo "Wating for maven PID=$PID to exit, running quite but errors and warn will be shown"

while kill -0 $PID 2>/dev/null
do
	DURATION=$((`date +"%s"` - $START))
	MINUTES=$(($DURATION / 60))
	MINPADDED=`printf "%02d" $MINUTES`
	SECONDS=$(($DURATION % 60))
	SECPADDED=`printf "%02d" $SECONDS`
	printf "\rElapsed=$MINPADDED:$SECPADDED  Load`uptime | cut -d: -f5`"
	sleep 1
done

wait $PID
CODE=$?
echo ""
if [ $CODE -ne 0 ]; then
	echo "Build failed. exit code $PID see above errors"
	exit 1
fi		

run-backend.sh $FUNC
