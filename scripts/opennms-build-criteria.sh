#!/bin/bash

#$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop
killall -9 java


cd $HOME/opennms/core/criteria
mvn clean compile install


SRC=$HOME/opennms/core/criteria/target/org.opennms.core.criteria-31.0.0-SNAPSHOT.jar
DEST=$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/system/org/opennms/core/org.opennms.core.criteria/31.0.0-SNAPSHOT/org.opennms.core.criteria-31.0.0-SNAPSHOT.jar
DEST2=$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/lib/org.opennms.core.criteria-31.0.0-SNAPSHOT.jar


cp $SRC $DEST
cp $SRC $DEST2

$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms -t start

echo "On second thoughts.. lets wait.."

until $(curl --output /dev/null --silent --head --fail http://localhost:8980/opennms); do     printf '.'; sleep 1; done

echo ""

echo "Done"
