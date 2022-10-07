#!/bin/bash

source var.sh
kill-nms.sh

MODULE=test-api.rest

cd ${OMNS_SRC}/core/test-api/rest
pwd
mvn clean install -DskipTests=true
SRC=${OMNS_SRC}/core/$MODULE/target/org.opennms.core.$MODULE-${VERSION}.jar
DEST=${OMNS_HOME}/system/org/opennms/core/org.opennms.core.$MODULE/${VERSION}/org.opennms.core.$MODULE-${VERSION}.jar
DEST2=${OMNS_HOME}/lib/org.opennms.core.$MODULE-${VERSION}.jar

deploy $SRC $DEST || exit 1
deploy $SRC $DEST2	|| exit 2

$OMNS_HOME/bin/opennms -t start

echo "On second thoughts.. lets wait.."
until $(curl --output /dev/null --silent --head --fail $URL); do     printf '.'; sleep 1; done

echo " up"
echo "Try browsing to $URL"

