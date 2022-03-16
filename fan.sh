#!/bin/bash

#
## config

# Temperature threshold in Celsius
threshold=60

# Time to keep the fan on (will run at full speed)
activetime=1

#
## code

#read current cpu temperature. 
curtemp=$(/usr/bin/sensors | grep pch_cannonlake -A2 | tr -s ' ' | tail -n 1 | cut -d'+' -f2 | cut -d'.' -f1)

#if it's above ${threshold}, pulse the fan for ${activetime} seconds
if [ ${curtemp} -gt 60 ]
then
	#TODO: if it's already on, we should do nothing, as the most probable thing is that it's been the user manually activating it
	echo "0" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable
	sleep ${activetime}
	echo "2" > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/pwm1_enable
fi

exit 0
