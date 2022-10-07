	#!/bin/bash
#
# If files are given, deploy them, then start and wait till site is up
#

source var.sh
kill-nms.sh


$HOME/opennms/target/opennms-${VERSION}/bin/opennms -t start

URL=http://localhost:8980/opennms
echo "On second thoughts.. lets wait.."
until $(curl --output /dev/null --silent --head --fail $URL); do     printf '.'; sleep 1; done

echo " up"
echo "Try browsing to $URL"

