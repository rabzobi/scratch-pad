#!/bin/bash

FILE=portal-common/portal-model/src/main/resources/portal.database.xml

if [ ! -f ] ; then
	echo "Can't find file: $FILE"
	exit 1
fi

liquibase --hub-mode=off update --changelog-file=$FILE --url='jdbc:postgresql://127.0.0.1:5432/portal?currentSchema=public' --username=opennms --password=qwerty 
