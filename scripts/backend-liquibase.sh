#!/bin/bash

liquibase update --changelog-file=portal-backend/portal-common/portal-model/src/main/resources/portal.database.xml --url='jdbc:postgresql://127.0.0.1:5432/portal?currentSchema=public' --username=portal --password=password
