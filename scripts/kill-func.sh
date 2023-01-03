#!/bin/bash

# Kill func process run frorm gradle as they don't die on <Ctrl> c exit

kill -9 `ps -aef | grep azure-functions-core-tools | grep -v grep | cut -d' ' -f4`

