#:/bin/bash

/root/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop
/root/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms -t start

until $(curl --output /dev/null --silent --head --fail http://localhost:8980/opennms); do     printf '.'; sleep 1; done

echo ""

echo "Done"
