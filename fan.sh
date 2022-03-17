#!/bin/sh

#
## config
###

# Temperature threshold in Celsius
threshold=60

# Time to keep the fan on (will run at full speed)
activetime=2

#
## code
###

getfandata() {
	# get which hwmon we have, as it changes and echoing to .../hwmon*/... would be a bashism
	setmonid=$(ls /sys/devices/platform/asus-nb-wmi/hwmon/ | grep hwmon* | head -n 1)
	getmonid=$(ls /sys/devices/platform/coretemp.0/hwmon/ | grep hwmon* | head -n 1)
	# get current fan status
	fanstatus=$(cat /sys/devices/platform/asus-nb-wmi/hwmon/${setmonid}/pwm1_enable)
	# read current temperature
	coretempval=$(cat /sys/devices/platform/coretemp.0/hwmon/${getmonid}/temp1_input | head -n 1)
	curtemp=${coretempval%000}
}

getstatus() {
	if [ ${fanstatus} -eq 2 ]; then
		echo "off"
	else
		echo "on"
	fi
}

switch_on() {
	getfandata
	# if the fan is idle continue
	if [ ${fanstatus} -eq 2 ]; then
		echo "0" >/sys/devices/platform/asus-nb-wmi/hwmon/${setmonid}/pwm1_enable
	else
		# exit with errcode -1. Fan was already running
		exit -1
	fi
}

switch_off() {
	getfandata
	# if the fan is running continue
	if [ ${fanstatus} -eq 0 ]; then
		echo "2" >/sys/devices/platform/asus-nb-wmi/hwmon/${setmonid}/pwm1_enable
	else
		# exit with errcode -1. Fan was already stopped
		exit -1
	fi
}

exec_pulsefan() {
	switch_on
	sleep ${activetime}
	switch_off
}

cron() {
	# if the fan is idle continue
	if [ ${fanstatus} -eq 2 ]; then
		# if it's above ${threshold}, pulse the fan for ${activetime} seconds
		if [ ${curtemp} -gt ${threshold} ]; then
			exec_pulsefan ${monid} ${activetime}
		fi
	else
		# exit with errcode -1. Fan was already running
		exit -1
	fi
}

pulse() {
	# if the fan is idle continue
	if [ ${fanstatus} -eq 2 ]; then
		exec_pulsefan ${monid} ${activetime}
	else
		# exit with errcode -1. Fan was already running
		exit -1
	fi
}

#
## Main
###

option=$1
getfandata

case $option in
"on")
	switch_on
	;;
"off")
	switch_off
	;;
"status")
	getstatus
	;;
"pulse")
	pulse
	;;
"cron")
	cron
	;;
*)
	echo "Wrong parameter(s)"
	echo ""
	echo "Usage: ${0} [on|off|status|pulse|cron]"
	echo ""
	echo ""
	;;
esac

exit 0
