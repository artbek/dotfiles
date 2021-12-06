while :
do
	TIMER=$(test -f ${HOME}/.timer && echo '[' $(cat ${HOME}/.timer) '] |')
	VOLUME=$(echo -en 'VOL:' $(amixer get Master | grep -oE "[0-9]+%"))
	IS_AC_POWER_ONLINE=$(cat /sys/class/power_supply/AC/online)
	BATTERY_STATUS=$( [[ ${IS_AC_POWER_ONLINE} == 1 ]] && echo '%%%' || echo '---' )
	BATTERY_CAPACITY=$(echo -en $(cat /sys/class/power_supply/BAT0/capacity))
	LOAD=$(uptime | sed 's/.*load average://' | cut -d ',' -f 1 | xargs)
	xsetroot -name " ${TIMER} ${VOLUME} | BAT: ${BATTERY_CAPACITY}% | CPU: ${LOAD} | >>> $(date '+%I:%M %p') <<< "

	if [ ${BATTERY_CAPACITY} -lt 10 ]; then
		if [ ${IS_AC_POWER_ONLINE} -eq 0 ]; then
			if [ -f $HOME/.battery.alarm.mp3 ]; then
				ffplay -loglevel quiet -nodisp -autoexit $HOME/.battery.alarm.mp3 2>/dev/null
			fi
		fi
	fi

	sleep 5
done &

setxkbmap -layout us
xset r rate 230 70

exec dwm

