#!/usr/bin/bash
# Attention:
# Change CRLF (Windows) to LF (Unix on AWS) in your Editor
#
# Set variable PARAMS
PARAMS='01_params.sh'
# check if PARAMS is set else exit
if [ ! -f "$PARAMS" ]; then
    echo "$PARAMS does not exist!"
    exit 1
fi
# import PARAMS
source "$PARAMS"
# Set variable MOD to node_modules
MOD="node_modules"
# Check if node_modules exists
if [ ! -d "$MOD" ]; then
    # If not then set variable file to package.json
    file="package.json"
    # Check if package.json exists
    if [ ! -f "$file" ]; then
      # exit if not
      echo "$file does not exist!"
      exit 1
    fi
    # else install dependencies
    echo "install test dependencies"
    npm install
fi

echo "test api of container $container"
npm test
