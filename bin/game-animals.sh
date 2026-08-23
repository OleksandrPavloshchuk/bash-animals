#!/usr/bin/env bash

# debug
#set -x

GREEN=$'\033[32m'
RESET=$'\033[0m'

greeting() {
	echo "Welcome in animals game!"
}

read_yes_or_no() {
	while true; do
		read -r -p "$1 (y/n) " YES_OR_NO
		if [[ "$YES_OR_NO" == "y" || "$YES_OR_NO" == "n" ]]; then
			break
		fi
	done
	echo "yes/no = ${YES_OR_NO}"
}

read_animal_from_base() {
	IFS=',' read -r NAME QUESTION YES_ID NO_ID < "../data/$ANIMAL_ID"	
}

ask_animal() {
	read_yes_or_no "Is is a ${GREEN}${NAME}${RESET}?"
}

#---
greeting

ANIMAL_ID="root"

# main loop
while true; do
	read_animal_from_base
	# TODO remove trace
	echo "name=$NAME, question=$QUESTION, yes_id=$YES_ID, no_id=$NO_ID"

	ask_animal
	
	
	# TODO
	break	
	
done # main loop


