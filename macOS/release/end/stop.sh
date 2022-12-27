#!/bin/bash

#set governor to ondemand on all host cores
for x in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "ondemand" > $x; done

#stop scream service for audio on host
sudo systemctl --user --machine=piotr@ stop screamvm.service
