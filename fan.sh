#!/bin/bash

#read current cpu temperature
TEMPE=$(/usr/bin/sensors | grep pch_cannonlake -A2 | tr -s ' ' | tail -n 1 | cut -d'+' -f2 | cut -d'.' -f1)

#if it's above 60C, pulse the fan for a second
if [ ${TEMPE} -gt 60 ]
then
	echo "0" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[0-9]/pwm1_enable
	sleep 1
	echo "2" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[0-9]/pwm1_enable
else
	#if below 60C, we make sure it's off
	echo "2" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[0-9]/pwm1_enable
fi

exit 0
