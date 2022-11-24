#!/bin/bash

FUNC=$1
APP=$FUNC-functionapp

if [ -z $FUNC ] ; then
	echo "Usage: $0 [internal|external|portal]"
	exit 1
fi

if [ ! -d $APP ] ; then
	echo "$APP directory does not exist. You must be in the root of the repod"
	exit 1
fi

echo "Starting run.... "

if [ -z $PG_PORTAL_URL ]; then
	echo "PG_PORTAL_URL not set"
	echo "Ignoring PG_PORTAL_USER & PG_PORTAL_PASSWORD"
	export PG_PORTAL_USER=""
	export PG_PORTAL_PASSWORD=""
	echo "Using values from $APP/local.settings.json"
	set grep ^PG_PORTAL $APP/local.settings.json
else 
	echo "Using portal parms"
	echo "PG_PORTAL_URL=$PG_PORTAL_URL"
	echo "PG_PORTAL_USER=$PG_PORTAL_USER"
	echo "PG_PORTAL_PASSWORD=$PG_PORTAL_PASSWORD"
fi

if [  -z $PG_INTERNAL_URL ]; then
	echo "PG_INTERNAL_URL not set"
	echo "Ignoring PG_INTERNAL_USER & PG_INTERNAL_PASSWORD"
	export PG_INTERNAL_USER=""
	export PG_INTERNAL_PASSWORD=""
	echo "Using values from $APP/local.settings.json"
	set grep ^PG_INTERNAL $APP/local.settings.json
else 
	echo "Using internal parms"
	echo "PG_INTERNAL_URL=$PG_INTERNAL_URL"
	echo "PG_INTERNAL_USER=$PG_INTERNAL_USER"
	echo "PG_INTERNAL_PASSWORD=$PG_INTERNAL_PASSWORD"
fi


if [ -z $OKTA_ISSUER ] ; then
	echp "OKTA_ISSUER not set"
	echo "Get your tocken, by taking your bearer, put it in jwt.io and use the ISS in the payload"
	echo "If you bearer changes you will need to change your bearer"
	exit 1
else
	echo "OKTA_ISSUER=$OKTA_ISSUER set"	
fi

mvn azure-functions:run -pl $APP -Dkotlin.compiler.incremental=true -DenableDebug 
