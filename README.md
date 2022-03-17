# fan-asus-ux333fa

## description
Script to control the fan on an Asus X333-FA laptop. As it doesn't seem to work with the existing solutions (fancontrol, ...) I made a few VERY simple scripts in order to be able to turn on and off the fan.

In the current kernel drivers at lest, there is no way to control the speed of the fan in any way, just to turn it on (full speed) or off. As leaving it on was annoying, the script just pulses.

Do not trust this script to keep your laptop cool. But when there is nothing else...better than nothing

## installation and usage
To install, just make the scripts executable, move them to /usr/local/bin/, and call fan.sh every minute from cron like this:
* * * * * /usr/local/bin/fan.sh cron > /dev/null 2>&1

There are 2 very basic scripts:
- fan.sh : if above 60C (configurable value), pulse the fan for a second (also configurable)
- fanpulse.sh : just pulses the fan for a second

## todo
- merge scripts
- ?
