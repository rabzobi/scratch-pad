#!/bin/bash
#
# Very basic build script
# 
# I set OPENNMS_HOME in my bash profile
# I also have scratch-pad/scripts on my PATH
#

kill-nms.sh
source var.sh

cd $OMNS_SRC
pwd

# Set open file limit
ulimit 999666

echo "Need to run this coz it won't run in script:"
echo "time (./clean.pl && ./compile.pl -U -DskipTests && ./assemble.pl -p dir -DskipTests)"

echo "echo RUNAS=$USER > $OPENNMS_HOME/etc/opennms.conf"
#sed -i 's,password="",password="YOUR-POSTGRES-PASSWORD",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1
#sed -i 's,password="",password="",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1

echo "$OPENNMS_HOME/bin/runjava -s"
echo "$OPENNMS_HOME/bin/install -dis"
