#!/usr/bin/env bash

modefile="/tmp/waybar_net_mode"

if [ ! -f "$modefile" ]; then
  echo ssid > "$modefile"
fi

mode=$(cat "$modefile")

if [ "$1" = "next" ]; then
  case "$mode" in
    ssid) newmode="ipv4" ;;
    ipv4) newmode="ipv6" ;;
    ipv6) newmode="ssid" ;;
    *) newmode="ssid" ;;
  esac
  echo "$newmode" > "$modefile"
  exit 0
fi

case "$mode" in
  ssid)
    ssid=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev | grep ':wifi:connected:' | cut -d: -f4)
    [ -z "$ssid" ] && ssid="⚠ Disconnected"
    echo " $ssid"
    ;;
  ipv4)
    ipv4=$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | grep -v '127.0.0.1' | head -n 1)
    [ -z "$ipv4" ] && ipv4="❌ No IPv4"
    echo "ipv4 : $ipv4"
    ;;
  ipv6)
    ipv6=$(ip -6 a show up | grep 'inet6' | awk '{print $2}' | tail -n 1)
    [ -z "$ipv6" ] && ipv6="❌ No IPv6"
    echo "ipv6 : $ipv6"
    ;;
esac
