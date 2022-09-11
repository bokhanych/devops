#!/bin/bash
clear;
echo -n "Number of user $USER processes: " && lslogins -o USER,PROC | grep "$USER" | awk '{print $2}'
echo -n "CPU load: " && grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
echo -n "Available memory in MB: " && awk '/MemAvailable/ { printf "%.3f \n", $2/1024 }' /proc/meminfo

echo -n "Enter port number or leave empty for all ports: "; read PORT;
if [[ -z "$PORT" ]]; then
echo "Established connection on all ports: "
netstat -ant | grep "ESTABLISHED" | tee >(wc -l)
else
echo "Established connection on $PORT port: "
netstat -ant | grep ":${PORT}" | grep "ESTABLISHED" | tee >(wc -l)
fi
