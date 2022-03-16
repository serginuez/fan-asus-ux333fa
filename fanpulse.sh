#!/bin/bash

#we just switch on the fan for a second and switch it off again
echo "0" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable
sleep 1
echo "2" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable

exit 0
