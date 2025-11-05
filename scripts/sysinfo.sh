#!/bin/bash

cpu=$(awk -v RS="" '{getline; cpu=($2+$4)*100/($2+$4+$5); printf "%d", cpu}' /proc/stat 2>/dev/null || cpu=0)
mem=$(free -m | awk '/Mem:/ {printf "%d", $3*100/$2}')

echo "<span foreground='#b794f4'>CPU ${cpu}%</span> | <span foreground='#f687b3'>MEM ${mem}%</span>"
