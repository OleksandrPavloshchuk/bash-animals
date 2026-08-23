#!/usr/bin/env bash

# debug
#set -x

greeting() {
	echo "Welcome in animals game!"
}

read_yes_or_no() {
	while true; do
		read -r -p "(y/n) " YES_OR_NO
		if [[ "$YES_OR_NO" == "y" || "$YES_OR_NO" == "n" ]]; then
			break
		fi
	done
	echo "yes/no = ${YES_OR_NO}"
}

#---
greeting

read_yes_or_no

echo "out = ${YES_OR_NO}"


