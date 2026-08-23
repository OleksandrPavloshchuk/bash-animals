#!/usr/bin/env bash

# debug
#set -x

GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RESET=$'\033[0m'

greeting() {
	echo "Welcome in animals game!"
}

read_yes_or_no() {
	while true; do
		read -r -p "$1? (y/n) " YES_OR_NO
		if [[ "$YES_OR_NO" == "y" || "$YES_OR_NO" == "n" ]]; then
			break
		fi
	done
}

read_animal_from_base() {
	IFS=',' read -r NAME QUESTION YES_ID NO_ID < "../data/$ANIMAL_ID"	
}

ask_animal() {
	read_yes_or_no "Is is a ${GREEN}${NAME}${RESET}"
}

ask_question() {
	read_yes_or_no "${QUESTION}"
}

ask_new_animal() {
	read -r -p "I surrender. What is it? " NEW_NAME
}

ask_and_save_new_animal_with_question() {
	ask_new_animal
	read -r -p "Enter a question to distinguish ${GREEN}${NAME}${RESET} (no) from ${GREEN}${NEW_NAME}${RESET} (yes) (without ?): " QUESTION
	YES_ID=$(uuidgen)
	echo "${NAME},${QUESTION},${YES_ID}," > "../data/$ANIMAL_ID"
	echo "${NEW_NAME},,," > "../data/$YES_ID"
}

ask_and_save_new_animal_without_question() {
	ask_new_animal
	NO_ID=$(uuidgen)
	echo "${NAME},${QUESTION},${YES_ID},${NO_ID}" > "../data/$ANIMAL_ID"
	echo "${NEW_NAME},,," > "../data/$NO_ID"	
}

print_I_win() {
	echo "${YELLOW}I win.${RESET}"
}

# Entry point
greeting

ANIMAL_ID="root"

# main loop
while true; do

	# TODO remove trace
	echo "TRACE: animal_id = $ANIMAL_ID"

	read_animal_from_base

	ask_animal
	if [[ "$YES_OR_NO" == 'y' ]]; then
		print_I_win
		break
	else
		if [[ "$QUESTION" == "" ]]; then
			ask_and_save_new_animal_with_question
			break
		else
			ask_question
			if [[ "$YES_OR_NO" == 'y' ]]; then
				ANIMAL_ID="$YES_ID"
			else
				if [[ "$NO_ID" == "" ]]; then
					ask_and_save_new_animal_without_question
					break
				else
					ANIMAL_ID="$NO_ID"
				fi # has NO_ID
			fi # ask question 
		fi # has question
	fi # ask animal
	
done # main loop


