#!/bin/bash

cd $HOME/opennms

ulimit 
time (./clean.pl && ./compile.pl -U -DskipTests && ./assemble.pl -p dir -DskipTests)
