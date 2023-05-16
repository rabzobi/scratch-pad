#!/usr/bin/env bash

#cd /Users/tbigger/Projects/OpenNMS/horizon-stream-cloud || exit 1
cd /Users/rellis/horizon-stream-project || exit 1
ls /Users/rellis/scratch-pad/scripts/docker-clean.sh || exit 2

# Cleanup
ctlptl delete cluster kind
/Users/rellis/scratch-pad/scripts/docker-clean.sh
rm -rf ~/.m2

# Startup
ctlptl create cluster kind --registry=ctlptl-registry
bash build-tools/basic/compile.sh
tilt up --port 10350 --stream