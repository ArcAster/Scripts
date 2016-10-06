#!/usr/bin/env bash
# This script fixes corrupt OSX tcp tables
# at times this is a side-effect of connecting to oVpn via WLAN

echo "[osx] disabling en0 interface"
sudo ifconfig en0 down # take the networking interface down

echo "[osx] clearing IP tables"
(sudo route flush) & pid=$! # flush the route table

echo "waiting..."
sleep 10 && kill -9 $pid


echo "[osx] re-enabling en0 interface"
sudo ifconfig en0 up # take the networking interface up
