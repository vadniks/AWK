#!/bin/bash

arg=$1
[ -z "$arg" ] && >&2 echo "argument not found" && exit 1

sudo chmod a+rx "$arg"
sudo cp "$arg" /usr/local/bin
