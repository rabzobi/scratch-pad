#!/bin/bash
#
# Very basic build script
# 
# I set OPENNMS_HOME in my bash profile
# I also have scratch-pad/scripts on my PATH
#

source var.sh
kill-nms.sh

cd $OMNS_SRC
pwd
ulimit 999666
time (./clean.pl && ./compile.pl -U -DskipTests && ./assemble.pl -p dir -DskipTests)

echo "RUNAS=$USER" > "$OPENNMS_HOME/etc/opennms.conf" || exit 1
#sed -i 's,password="",password="YOUR-POSTGRES-PASSWORD",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1
#sed -i 's,password="",password="",g' "$opennms_target_version/etc/opennms-datasources.xml" || exit 1

eval "$OPENNMS_HOME/bin/runjava -s" || exit 1
eval "$OPENNMS_HOME/bin/install -dis" || exit 1

echo "Done"
exit 0
