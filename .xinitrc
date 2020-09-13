setxkbmap -layout gb

while :
do
	TIMER=$(test -f ${HOME}/.timer && echo '[' $(cat ${HOME}/.timer) '] |')
	VOLUME=$(echo -en 'VOL:' $(amixer get Master | grep -oE "[0-9]+%"))
	IS_AC_POWER_ONLINE=$(cat /sys/class/power_supply/AC/online)
	BATTERY_STATUS=$( [[ ${IS_AC_POWER_ONLINE} == 1 ]] && echo '%%%' || echo '---' )
	BATTERY_CAPACITY=$(echo -en 'BAT:' $(cat /sys/class/power_supply/BAT0/capacity)%)
	LOAD=$(uptime | sed 's/.*load average://' | cut -d ',' -f 1 | xargs)
	xsetroot -name " ${TIMER} ${VOLUME} | ${BATTERY_CAPACITY} | CPU: ${LOAD} | >>> $(date '+%I:%M %p') <<< "
	sleep 5
done &

xset r rate 230 70

setxkbmap -option caps:escape

exec dwm
