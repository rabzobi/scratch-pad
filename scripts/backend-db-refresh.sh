#!/bin/bash

PASS=$1
if [ -z $PASS ] ; then
	echo "Usage: $0 DEV-PASSWORD"
	exit 1
fi

pg_dump "host=opennms-dev.postgres.database.azure.com port=5432 dbname=portal user=opennms@opennms-dev  password='$PASS' sslmode=require" > portal.sql
pg_dump "host=opennms-dev.postgres.database.azure.com port=5432 dbname=internal user=opennms@opennms-dev  password='$PASS sslmode=require" > internal.sql

sudo docker restart postgres_container

dropdb -h 127.0.0.1 -U opennms internal; createdb -h 127.0.0.1 -U opennms internal
dropdb -h 127.0.0.1 -U opennms portal; createdb -h 127.0.0.1 -U opennms portal

cat portal.sql |  psql -h 127.0.0.1 -U opennms portal
cat internal.sql |  psql -h 127.0.0.1 -U opennms internal

