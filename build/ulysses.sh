#!/bin/bash
dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export dir=$dir"/_ulysses"
export bin="$dir/bin/"
source $dir/.menu_cmds

clr="\e[0m"
bold="$clr\e[1m"
dim="$clr\e[2m"
logoColor="\e[38;5;161m"
you="\e[93m"
bod="\e[38;5;69m"

red='\e[1;31m'

current="ulysses"
user=$(id -u -n)

p1="$bod┌──($bold$you$user$clr$bod)"
p2="$bod╰──────[$bold$current$clr$bod]──╡$bold\$$clr: "

_prompt() {
	echo -ne "$p1\n$p2"
	read -r user_in

	if [[ -n "${commands[$user_in]}" ]]; then
		$user_in
	else
		case $user_in in
			"reload" )
				source $dir/.menu_cmds
				_logo;;

			"quit"|"exit" )
				clear
				exit 0;;

			"help")
				clear
				echo -e "$logoColor$LOGO$clr\n"
				help;;

			"clear"|"cls"|"clr"|"^L")
				clear
				echo -e "$logoColor$LOGO$clr\n";;

			*)
				echo -e "$red[COMMAND NOT FOUND]: ${user_in}$clr\n";;
		esac
	fi
}

_logo() {
    rand=$(( $(( $RANDOM % 7 )) + 1 ))
    num=${1:-$rand}
    LOGO=$(cat $dir/logos/$num.txt)
	$(clear >&2)
	echo -e "$logoColor$LOGO$clr\n"
}

_logo
while true; do
	_prompt # simple loop to keep prompt up
done