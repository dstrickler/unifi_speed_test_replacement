#!/bin/bash
#
# Written by DStrickler on Thu, Oct 10, 2019
# Warning: There is no error checking in here yet
# Assumes exectable "bc" is installed by hand.
#
USERNAME="{put your username here}"

# Run the test and upload it to SQL
/usr/bin/speedtest --json > /tmp/speedtest.json

# EPOC value
EPOC=`date +%s`
echo "$EPOC" > "lastrun"
cat lastrun | ssh $USERNAME@10.0.1.1 "sudo tee /run/linkcheck/speedtest/lastrun"

# ping
LATENCY=`cut -d':' -f21 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1' | cut -d'}' -f1`
echo $LATENCY
echo "$LATENCY" > "ping"
cat ping | ssh $USERNAME@10.0.1.1 "sudo tee /run/linkcheck/speedtest/ping"


# Download speed
DOWNLOAD=`cut -d':' -f2 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1'`
DOWNLOAD=`echo "scale=2; $DOWNLOAD / 1000000" | bc`
echo "$DOWNLOAD" > "xput_down"
cat xput_down | ssh $USERNAME@10.0.1.1 "sudo tee /run/linkcheck/speedtest/xput_down"

#upload speed
UPLOAD=`cut -d':' -f3 /tmp/speedtest.json | cut -d',' -f1 | awk '{$1=$1};1'`
UPLOAD=`echo "scale=2; $UPLOAD / 1000000" | bc`
echo "$UPLOAD" > "xput_up"
cat xput_up | ssh $USERNAME@10.0.1.1 "sudo tee /run/linkcheck/speedtest/xput_up"
