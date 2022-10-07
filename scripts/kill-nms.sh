#!/bin/bash
#
# Kill it coz it won't stop
#

PID=`ps aux | grep opennms | grep -v grep | awk '{print $2}'`

#echo "PID=$PID"

if [ ! -z "$PID" ] ; then
	echo "Killing pid=$PID"
	kill -9 $PID
	echo "Kill done"
else
	echo "No running instance found."
fi

echo "Kill script done"
