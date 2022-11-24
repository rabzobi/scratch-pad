#!/bin/bash

source var.sh
kill-nms.sh

cd ${OMNS_SRC}/opennms-webapp-rest
pwd
mvn clean install -DskipTests=true

SRC=$HOME/opennms/opennms-webapp-rest/target/opennms-webapp-rest-31.0.0-SNAPSHOT/WEB-INF/lib/opennms-webapp-rest-${VERSION}.jar
DEST=$HOME/opennms/target/opennms-${VERSION}/jetty-webapps/opennms/WEB-INF/lib/opennms-webapp-rest-${VERSION}.jar
DEST2=$HOME/opennms/target/opennms-${VERSION}/jetty-webapps/opennms/WEB-INF/lib/opennms-webapp-rest-${VERSION}.jar


deploy $SRC $DEST || exit 1
deploy $SRC $DEST2	|| exit 2

start-nms.sh


