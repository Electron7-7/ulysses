#!/bin/bash
export dir=$(pwd)
export bin="$dir/bin/"
source $dir/.menu_cmds

clr="\e[0m"
bold="$clr\e[1m"
dim="$clr\e[2m"
logoColor="\e[38;5;161m"
you="\e[93m"
bod="\e[38;5;69m"

keepup=true
current="ulysses"
user=$(id -u -n)

p1="$bod┌──($bold$you$user$clr$bod)"
p2="$bod╰──────[$bold$current$clr$bod]──╡$bold\$$clr: "

_prompt() {
	echo -ne "$p1\n$p2"
	read -r user_in
	if [[ ${user_in} == "reload" ]]; then
		source $dir/.menu_cmds
		_logo
	elif [[ ${user_in} == "quit" || ${user_in} == "exit" ]]; then
		clear & exit 0
	elif [[ ${commands[*]} =~ ${user_in} ]]; then
		$user_in
	fi
}

_logo() {
    num=$(( $(( $RANDOM % 7 )) + 1 ))
    LOGO=$(cat ./logos/$num.txt)
	$(clear >&2)
	echo -e "$logoColor$LOGO$clr\n\n"
}


_logo

while $keepup; do
	_prompt # simple loop to keep prompt up
done