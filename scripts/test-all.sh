#!/bin/bash

kill-nms.sh

cd $OPENNMS_SRC/opennms-webapp-rest
mvn test '-Dtest=**IT' || exit 1

cd $OPENNMS_SRC/features/rest/mapper/
mvn test '-Dtest=**Test' || exit 1

cd $OPENNMS_SRC/smoke-test/
mvn test -Dtest=org.opennms.smoketest.ClassificationRulePageIT || exit 1
