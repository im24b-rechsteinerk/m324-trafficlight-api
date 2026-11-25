#!/bin/bash
#
# Usage: ./06_scp.sh <public-ip-of-ec2>
#
# Set variable for target node (your AWS EC2 instance)
DEST="ubuntu@${1:?Usage: ./06_scp.sh <public-ip-of-ec2>}"
# Set variable for target directory where the app should be stored
TRG="~/03"
# Set private key
PRIVATE_KEY=~/.ssh/labsuser.pem
# check if private key is set
if [ ! -f "$PRIVATE_KEY" ]; then
  echo "$PRIVATE_KEY does not exist!"
  exit 2
fi
# remove (with ssh) target directory for the app
ssh -i "$PRIVATE_KEY" "$DEST" "rm -rf ${TRG}"
# create (with ssh) target directory for the app
ssh -i "$PRIVATE_KEY" "$DEST" "mkdir ${TRG}"
# copy (with scp) all bash script to destination
scp -i "$PRIVATE_KEY" 0{1..5}*.sh "$DEST:${TRG}"
# copy (with scp) the backend to destination
scp -r -i "$PRIVATE_KEY" backend "$DEST:${TRG}"
# copy (with scp) dockerfile to destination
scp -i "$PRIVATE_KEY" Dockerfile "$DEST:${TRG}"
# copy (with scp) unit testing files to destination
scp -i "$PRIVATE_KEY" package.json trafficlight.test.js "$DEST:${TRG}"
# make the scripts executable
ssh -i "$PRIVATE_KEY" "$DEST" "chmod +x ${TRG}/*.sh"
