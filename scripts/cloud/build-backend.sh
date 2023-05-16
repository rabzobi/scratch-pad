#!/bin/bash

FUNC=$1
CLEAN=$2
APP=$FUNC-functionapp

if [ -z $FUNC ] ; then
	echo "Usage: $0 [internal|external|portal] (CLEAN)"
	echo "Add clean if you want it"
	exit 1
fi

if [ ! -d $APP ] ; then
	echo "$APP directory does not exist. You must be in the root of the repo"
	exit 1
fi

if [ -z $CLOUDSUFFIX ] ; then
	echo "CLOUDSUFFIX not set"
	exit 1
fi


echo "Compiling with CLOUDSUFFIX=$CLOUDSUFFIX"
if [ ! -z $CLEAN ] ; then
	echo "With clean"
	CLEAN=clean
fi
START=`date +"%s"`
mvn --quiet -T 4 package $CLEAN -pl $APP -am -Dkotlin.compiler.incremental=true -DskipTests &
PID=$! 

echo "Waiting for maven PID=$PID to exit, running quite"

while kill -0 $PID 2>/dev/null
do
	DURATION=$((`date +"%s"` - $START))
	MINUTES=$(($DURATION / 60))
	MINPADDED=`printf "%02d" $MINUTES`
	SECONDS=$(($DURATION % 60))
	SECPADDED=`printf "%02d" $SECONDS`
	printf "\rElapsed=$MINPADDED:$SECPADDED"
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
