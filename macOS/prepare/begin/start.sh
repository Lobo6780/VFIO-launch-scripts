#!/bin/bash

#start scream service for audio on host
sudo systemctl --user --machine=piotr@ start screamvm.service

#compact memory under host and drop cached memory
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
#not used hugepages
#echo 16 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
#echo 8192 > /proc/sys/vm/nr_hugepages

#set governor to performance on all host cores to boost on guest (macos)
for x in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $x; done
