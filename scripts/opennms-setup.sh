#!/bin/bash

version_prefix=31.0.0-SNAPSHOT
opennms_root=/root/opennms
opennms_target_version="$opennms_root/target/opennms-$version_prefix"

#kill -9 $(ps aux | grep opennms | grep -v grep | awk '{print $2}')

echo "RUNAS=$(id -u -n)" > "$opennms_target_version/etc/opennms.conf" || exit 1
#sed -i 's,password="",password="YOUR-POSTGRES-PASSWORD",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1
#sed -i 's,password="",password="",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1

eval "$opennms_target_version/bin/runjava -s" || exit 1
eval "$opennms_target_version/bin/install -dis" || exit 1

echo "Done"
exit 0

