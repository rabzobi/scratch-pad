#!/bin/bash

PASS=$1
if [ -z $PASS ] ; then
	echo "Usage: $0 DEV-PASSWORD"
	exit 1
fi

echo "Refreshing DBs with password='$PASS'"

echo "Dumping portal db"
pg_dump "host=opennms-dev.postgres.database.azure.com port=5432 dbname=portal user=opennms@opennms-dev  password='$PASS' sslmode=require" > portal.sql

echo "Dumping internal db"
pg_dump "host=opennms-dev.postgres.database.azure.com port=5432 dbname=internal user=opennms@opennms-dev  password='$PASS' sslmode=require" > internal.sql



echo "Restarting docker to kill open connections.."
sudo docker restart postgres_container

echo "Waiting 10 seconds"
sleep 10

echo "Starting drops"
dropdb -h 127.0.0.1 -U opennms internal; createdb -h 127.0.0.1 -U opennms internal
dropdb -h 127.0.0.1 -U opennms portal; createdb -h 127.0.0.1 -U opennms portal

echo "Starting imports"
cat portal.sql |  psql -h 127.0.0.1 -U opennms portal
cat internal.sql |  psql -h 127.0.0.1 -U opennms internal

