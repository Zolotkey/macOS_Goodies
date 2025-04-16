#!/usr/bin/env zsh

lowPowerModeStatus=$(pmset -g custom | awk '/lowpowermode/ { a[$2]++ } END { for (b in a) { print b } }')

if [[ "${lowPowerModeStatus}" == "0" ]]; then
	echo "lowpowermode is disabled"
	exit 1
elif [[ "${lowPowerModeStatus}" == "1" ]]; then
	echo "lowpowermode is on"
	exit 0
else
	echo "lowpowermode is mixed on and off"
	exit 1
fi
