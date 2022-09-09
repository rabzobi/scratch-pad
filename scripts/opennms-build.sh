#!/bin/bash


$HOME/opennms/target/opennms-31.0.0-SNAPSHOT/bin/opennms stop

cd $HOME/opennms
ulimit 
time (./clean.pl && ./compile.pl -U -DskipTests && ./assemble.pl -p dir -DskipTests)
