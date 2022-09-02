#!/bin/bash

cd /root/opennms

ulimit -n 1000000
time (./clean.pl && ./compile.pl -U -DskipTests && ./assemble.pl -p dir -DskipTests)
