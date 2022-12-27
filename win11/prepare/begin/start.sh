#!/bin/bash

#start scream audio receiver on host
sudo systemctl --user --machine=piotr@ start screamvm.service

#unmount guest hdd drive from host
umount -fl /mnt/winhdd

#drop cached memory and compact it
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
#not used hugepages, not always work
#echo 16 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
#echo 8192 > /proc/sys/vm/nr_hugepages

#set host cpus to performance
for x in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $x; done

#set cores 1 and 2 (and their threads) to be used only by linux hypervisor
systemctl set-property --runtime -- user.slice AllowedCPUs=0,6,1,7
systemctl set-property --runtime -- system.slice AllowedCPUs=0,6,1,7
systemctl set-property --runtime -- init.scope AllowedCPUs=0,6,1,7
