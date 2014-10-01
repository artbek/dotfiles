#!/bin/bash

CURRENT_DIR=$(dirname "${BASH_SOURCE}")
source ${CURRENT_DIR}/cdup/cdup.sh


function PWD {
	folders=(`echo $(pwd) | sed 's!/! !g'`)
	folders_count=${#folders[@]}
	let folders_count=folders_count-1
	display_path=''
	counter=0
	while [ $counter -lt 4 ]; do
		let index=$[folders_count-counter]
		if [ $index -ge 0 ]; then
			if [ ${#display_path} -eq 0 ]; then
				display_path=${folders[$index]}
			else
				display_path=${folders[$index]}/$display_path
			fi
		fi
		let counter=counter+1
	done
	echo $display_path

	# e.g. export PS1="\[\e[38;5;220m\][\$(PWD)]\$\[\e[0m\] "
}


function print_colors() {
	for index in {0..255}
 	do
		echo -en "\e[38;5;${index}m"
		echo -n "${index} "
		echo -en "\e[0m"
	done
	echo
}


function lines() {
	if [[ ${#1} > 0 ]] && [[ ${#2} > 0 ]] && [[ ${#3} > 0 ]]; then
		display_lines=$3
		let "middle=$2+($display_lines/2)"
		cat $1 -n | head -n$middle | tail -n$display_lines
	else
		echo "Usage: lines [FILENAME] [MIDDLE_LINE_NUMBER] [NUMBER_OF_LINES_TO_DISPLAY]"
	fi
}


function git() {
	if [[ $1 == lg && $2 =~ q+$ ]]; then
		let temp_count=${#2}
		let replace_with="-$temp_count"0
		echo Running: git "${@/$2/$replace_with}"
		command git "${@/$2/$replace_with}"
	else
		command git "$@" # man 7 bash-builtins
	fi
}

