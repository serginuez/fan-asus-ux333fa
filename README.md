# fan-asus-ux333fa

## description
POSIX Shell Script to control the fan on an Asus UX333-FA laptop. As it doesn't seem to work with the existing solutions (fancontrol, ...), I made a VERY simple script in order to be able to turn on and off the fan.

In the current kernel drivers at lest, there is no way to control the speed of the fan in any way, just to turn it on (full speed) or off. As leaving it on was annoying, the script just pulses.

Do not trust this script to keep your laptop cool. But when there is nothing else...better than nothing

## installation and usage
To install, just make the script executable, move it to /usr/local/bin/, and call fan.sh every minute from cron like this:
```
* * * * * /usr/local/bin/fan.sh cron > /dev/null 2>&1
```

Usage:
```
/usr/local/bin/fan.sh [status|on|off|pulse|cron]

Script options:
- status: displays the current fan status, on or off
- on: switches the fan on
- off: switches the fan off
- pulse: pulses the fan for an amount of seconds (configurable value in the script)
- cron: if above 60C (configurable value), pulse the fan for two seconds (also configurable)
```

## todo
- allow parametres for threshold temp and pulse time
- ?
