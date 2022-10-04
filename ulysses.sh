#!/bin/bash
export DIR=$(pwd)
export BIN="$DIR/bin/"
export MCS="$BIN/menu_commands/"
export keepup=true

clr="\e[0m"
bold="$clr\e[1m"
dim="$clr\e[2m"
logoColor="\e[38;5;161m"
you="\e[93m"
bod="\e[38;5;69m"

current="ulysses"
user=$(id -u -n)
p1="$bod┌──($bold$you$user$clr$bod)"
p2="$bod╰──────[$bold$current$clr$bod]──╡$bold\$$clr: "

_action() {
	if [[ -e "$MCS/$getin" ]]; then
		. $MCS/$getin
	fi
}

_prompt() {
	echo -e -n "$p1\n$p2"
	read -r getin
	_action
}

_logo() {
    num=$(( $(( $RANDOM % 7 )) + 1 ))
    LOGO=$(cat ./logos/$num.txt)
	$(clear >&2)
	echo -e "$logoColor$LOGO$clr\n\n"
}

_main() {
	# call the logo function
	_logo
	# simple loop to keep prompt up
	while $keepup; do
		_prompt
	done
}

_main