#!/bin/sh

OUTPUT="/tmp/system-info.txt"

echo "=== EXPORT SYSTEM INFO ==="

echo "[+] Salvando em $OUTPUT"

{
echo "===== SYSTEM ====="
uname -a
echo ""

echo "===== RELEASE ====="
cat /etc/openwrt_release
echo ""

echo "===== NETWORK ====="
ip a
echo ""

echo "===== ROUTES ====="
ip route
echo ""

echo "===== WIFI ====="
iw dev
echo ""

echo "===== DISK ====="
df -h
echo ""

echo "===== MEMORY ====="
free -h
echo ""

} > $OUTPUT

echo "[+] Done."