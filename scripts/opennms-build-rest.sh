#!/bin/bash

$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop

cd $HOME/opennms/opennms-webapp-rest
mvn clean compile install

SRC=$HOME/opennms/opennms-webapp-rest/target/opennms-webapp-rest-31.0.0-SNAPSHOT/WEB-INF/lib/opennms-webapp-rest-31.0.0-SNAPSHOT.jar
DEST=$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/jetty-webapps/opennms/WEB-INF/lib/opennms-webapp-rest-31.0.0-SNAPSHOT.jar

cp $SRC $DEST

$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms -t start

echo "On second thoughts.. lets wait.."

until $(curl --output /dev/null --silent --head --fail http://localhost:8980/opennms); do     printf '.'; sleep 1; done

echo ""

echo "Done"
