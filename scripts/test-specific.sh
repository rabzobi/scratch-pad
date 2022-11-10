#!/bin/bash

kill-nms.sh


rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/poller/monitors/core
mvn clean install test '-Dtest=org.opennms.netmgt.poller.monitors.SmtpMonitorIT' -U || exit 1
echo "SmtpMonitorIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/tests/dao/
mvn clean install test '-Dtest=org.opennms.netmgt.dao.stats.AlarmStatisticsServiceIT' -U || exit 1
echo "AlarmStatisticsServiceIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/rest/mapper
mvn clean install test '-Dtest=org.opennms.web.rest.mapper.v2.AlarmMapperTest' -U || exit 1
echo "TEST: AlarmMapperTest done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/opennms-services
mvn clean install test '-Dtest=org.opennms.netmgt.notifd.HttpNotificationStrategyIT' -U || exit 1
echo "HttpNotificationStrategyIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/tests/dao
mvn clean install test '-Dtest=org.opennms.netmgt.dao.stats.AlarmStatisticsServiceIT' -U || exit 1
echo "AlarmStatisticsServiceIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/opennms-dao-mock
mvn clean install test '-Dtest=org.opennms.netmgt.dao.mock.BeanWrapperVisitorTest' -U || exit 1
echo "BeanWrapperVisitorTest done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/opennms-services
mvn clean install test '-Dtest=org.opennms.netmgt.snmpinterfacepoller.pollable.SnmpInterfacePollerIT' -U || exit 1
echo "SnmpInterfacePollerIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/rest/mapper
mvn clean install test '-Dtest=org.opennms.web.rest.mapper.v2.EventMapperTest' -U || exit 1
echo "EventMapperTest done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/flows/classification/persistence/impl
mvn clean install test '-Dtest=org.opennms.netmgt.flows.classification.persistence.impl.ClassificationRuleDaoIT'-U || exit 1
echo "ClassificationRuleDa0oIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/poller/monitors/core
mvn clean install test '-Dtest=org.opennms.netmgt.poller.monitors.SshMonitorIT' -U || exit 1
echo "SshMonitorIT done"

rm -rf ~/.m2/repository/org/codehaus/jackson
cd $OPENNMS_SRC/features/flows/classification/engine/impl/
mvn clean install test '-Dtest=org.opennms.netmgt.flows.classification.internal.DefaultClassificationEngineIT' -U || exit 1
echo "DefaultClassificationEngineIT done"

#cd $OPENNMS_SRC/
#mvn test '-Dtest=' || exit 1
