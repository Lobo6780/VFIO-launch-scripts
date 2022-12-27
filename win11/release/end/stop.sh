#!/bin/bash

#set host cpus to ondemand
for x in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "ondemand" > $x; done

#return all of cpus to host os
systemctl set-property --runtime -- user.slice AllowedCPUs=0-11
systemctl set-property --runtime -- system.slice AllowedCPUs=0-11
systemctl set-property --runtime -- init.scope AllowedCPUs=0-11

#return hugepages to normal value
#echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

#do not rush to mount drive
sleep 1

#stop audio receiver
sudo systemctl --user --machine=piotr@ stop screamvm.service

#mount hdd back to host
mount /dev/disk/by-id/ata-ST1000DM003-1CH162_S1DGC91Z /mnt/winhdd
