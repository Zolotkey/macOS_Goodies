#!/usr/bin/env zsh

startupMuteSet=$(nvram -p | awk '/StartupMute/')
startupMuteStatus=$(nvram StartupMute | awk '{gsub("%0",""); print $2}')

if [[ -z "${startupMuteSet}" ]]; then
	echo "StartupMute not Set"
	exit 1
elif [[ -z "${startupMuteStatus}" ]]; then
	echo "StartupMute is disabled" 
	exit 1
else
	exit 0
fi
