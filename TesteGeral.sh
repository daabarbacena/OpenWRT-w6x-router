#!/bin/sh

echo "=== FULL DIAGNOSTIC ==="

echo ""
echo "[SYSTEM]"
uptime
df -h
free -h

echo ""
echo "[NETWORK]"
ip a
ip route

echo ""
echo "[CONNECTIVITY]"
ping -c 2 8.8.8.8
ping -c 2 google.com

echo ""
echo "[WIFI]"
iw dev
iw reg get

echo ""
echo "[DONE]"
