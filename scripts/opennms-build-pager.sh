killall -9 java

cd ~/opennms-pagerduty-plugin

mvn clean compile install

cp ~/opennms-pagerduty-plugin/assembly/kar/target/opennms-pagerduty-plugin.kar ~/opennms/target/opennms-31.0.0-SNAPSHOT/deploy/
#cp ~/opennms-pagerduty-plugin/assembly/kar/target/org.opennms.plugins.pagerduty.assembly.kar-0.1.4-SNAPSHOT.kar ~/opennms/target/opennms-31.0.0-SNAPSHOT/deploy/


echo 'opennms-plugins-pagerduty wait-for-kar=opennms-pagerduty-plugin' | tee ~/opennms/target/opennms-31.0.0-SNAPSHOT/etc/featuresBoot.d/pagerduty.boot


mv ~/opennms/target/opennms-31.0.0-SNAPSHOT/logs/karaf.log  ~/opennms/target/opennms-31.0.0-SNAPSHOT/logs/karaf.log-`date +%s`

~/scratch-pad/scripts/opennms-restart.sh


echo "feature:install opennms-plugins-pagerduty"
echo "config:edit org.opennms.plugins.pagerduty"
echo "property-set client OpenNMS"
echo "property-set alarmDetailsUrlPattern 'http://localhost:8980/opennms/alarm/detail.htm?id=%d'"
echo "config:update"
echo ""
echo "config:edit --alias core --factory org.opennms.plugins.pagerduty.services"
echo "property-set routingKey \"bf0725a2bffb4904c00de7a871530625\""
echo "config:update"
echo ""

ssh -p 8101 admin@localhost

	
