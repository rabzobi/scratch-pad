#!/bin/bash

source var.sh
kill-nms.sh

cd ${OMNS_SRC}/opennms-web-api
pwd
mvn clean compile install

SRC=$HOME/opennms/opennms-web-api/target/opennms-web-api-${VERSION}.jar
DEST=$HOME/opennms/target/opennms-${VERSION}/system/org/opennms/opennms-web-api/31.0.0-SNAPSHOT/opennms-web-api-${VERSION}.jar
DEST2=$HOME/opennms/target/opennms-${VERSION}/lib/opennms-web-api-${VERSION}.jar

deploy $SRC $DEST || exit 1
deploy $SRC $DEST2	|| exit 2

start-nms.sh
