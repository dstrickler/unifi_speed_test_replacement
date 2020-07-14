#!/bin/bash
#
# Written by DStrickler on Thu, Oct 10, 2019
# Warning: There is no error checking in here yet
# Assumes exectable "bc" is installed by hand.
#
USERNAME="{your username to log into the Unifi router}"
UNIFI_ROUTER="{IP address of your Unifi router}"

# Run the test and upload it to SQL
echo "Running speedtest - stand by..."
/usr/bin/speedtest --json > /tmp/speedtest.json

# EPOC value
EPOC=`date +%s`
echo "$EPOC" > "lastrun"
cat lastrun | ssh $USERNAME@$UNIFI_ROUTER "sudo tee /run/linkcheck/speedtest/lastrun"

# ping
echo "Sensing ping."
LATENCY=`cut -d':' -f6 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1' | cut -d'}' -f1`
echo "Ping set to $LATENCY"
echo "$LATENCY" > "ping"
cat ping | ssh $USERNAME@$UNIFI_ROUTER "sudo tee /run/linkcheck/speedtest/ping"
echo "------------------------------"

# Download speed
echo "Sening download speed"
DOWNLOAD=`cut -d':' -f2 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1'`
DOWNLOAD=`echo "scale=2; $DOWNLOAD / 1000000" | bc`
echo "Download set to $DOWNLOAD"
echo "$DOWNLOAD" > "xput_down"
cat xput_down | ssh $USERNAME@#UNIFI_ROUTER "sudo tee /run/linkcheck/speedtest/xput_down"
echo "------------------------------"

#upload speed
echo "Sensing upload speed"
UPLOAD=`cut -d':' -f7 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1'`
UPLOAD=`echo "scale=2; $UPLOAD / 1000000" | bc`
echo "Upload set to $UPLOAD"
echo "$UPLOAD" > "xput_up"
cat xput_up | ssh $USERNAME@$UNIFI_ROUTER "sudo tee /run/linkcheck/speedtest/xput_up"
