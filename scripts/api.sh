#!/bin/bash

/root/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop

cd /root/opennms/opennms-web-api
mvn clean compile install

SRC=/root/opennms/opennms-web-api/target/opennms-web-api-31.0.0-SNAPSHOT.jar
DEST=/root/opennms/target/opennms-31.0.0-SNAPSHOT/system/org/opennms/opennms-web-api/31.0.0-SNAPSHOT/opennms-web-api-31.0.0-SNAPSHOT.jar
DEST2=/root/opennms/target/opennms-31.0.0-SNAPSHOT/lib/opennms-web-api-31.0.0-SNAPSHOT.jar

cp $SRC $DEST
cp $SRC $DEST2

/root/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms start

until $(curl --output /dev/null --silent --head --fail http://localhost:8980/opennms); do     printf '.'; sleep 1; done

echo ""

echo "Done"
