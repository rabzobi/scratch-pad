#!/usr/bin/env bash

#cd /Users/tbigger/Projects/OpenNMS/horizon-stream-cloud || exit 1
cd /Users/rellis/horizon-stream-project || exit 1

# Cleanup
ctlptl delete cluster kind
docker container rm "$(docker container ps -a -q)"
docker rmi "$(docker image ls -a -q)" --force
docker rmi "$(docker image ls -a -q)" --force
docker volume rm "$(docker volume ls -q)"
docker system prune --force
rm -rf ~/.m2

# Startup
ctlptl create cluster kind --registry=ctlptl-registry
bash build-tools/basic/compile.sh
tilt up --port 10350 --stream