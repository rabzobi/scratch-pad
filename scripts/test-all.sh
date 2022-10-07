#!/bin/bash

kill-nms.sh

cd $OPENNMS_SRC/opennms-webapp-rest
mvn clean test '-Dtest=IfServicesRestServiceIT'

mvn test '-Dtest=MonitoringLocationRestServiceIT'
mvn test '-Dtest=ClassificationRulePageIT'

exit 1

cd $OPENNMS_SRC/features/rest/mapper/
mvn test '-Dtest=**Test'


cd $OPENNMS_SRC/smoke-test/
mvn test -Dtest=org.opennms.smoketest.ClassificationRulePageIT
