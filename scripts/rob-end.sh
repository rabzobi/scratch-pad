#!/bin/bash

FUNC=$1
APP=$FUNC-functionapp
LOG=run.log

if [ -z $FUNC ] ; then
	echo "Usage: $0 [internal|external|portal]"
	exit 1
fi


if [ ! -d $APP ] ; then
	echo "$APP directory does not exist"
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

echo "Wating for maven PID=$PID to exit"

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
	echo "Build failed"
	exit 1
fi

echo "Starting run..."
set | grep PG_PORTAL_USER
set | grep PG_PORTAL_PASSWORD
set | grep PG_PORTAL_URL
set | grep OKTA_ISSUER
mvn azure-functions:run -pl $APP -Dkotlin.compiler.incremental=true -DenableDebug 

echo "Exit"