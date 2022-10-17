#!/bin/bash
dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
clr='\e[00m'
orang='\e[38;5;202m'
red='\e[1;91m'
gren='\e[1;92m'

_install() {
	echo -e "$gren[INSTALLING FILES]$clr"
	mkdir /usr/local/bin/_ulysses
	cp $dir/build/ulysses.sh /usr/local/bin/ulysses
	cp $dir/build/.menu_cmds /usr/local/bin/_ulysses/
	cp -r $dir/build/bin/ /usr/local/bin/_ulysses/
	cp -r $dir/build/logos/ /usr/local/bin/_ulysses/

	echo -e "$gren[SUCCESSFULLY INSTALLED ulysses]$clr"
	echo "You can now run ulysses from the command line! Give it a try!"
	exit 0
}

_reinstall() {
	echo -e "$red[DELETING OLD FILES]$clr"
	sudo rm /usr/local/bin/ulysses
	sudo rm -rf /usr/local/bin/_ulysses/
	sleep 0.5
	echo -e "$gren[OLD FILES REMOVED]$clr"
	echo -e "Continuing installation"

	_install
}

if [[ -e /usr/local/bin/_ulysses ]]; then
	echo -e "$orang[WARNING]$clr\nDetected existing install!"
	echo "reinstalling will completely remove all existing files and replace them with the latest version"
	echo "do you want to continue?"

	while true; do
		echo -n "[Y/N]: "
		read ans
		case $ans in
			[Yy]* )
				_reinstall;;
			[Nn]* )
				echo "[QUITTING INSTALL]"
				sleep 0.5
				exit 0;;
			*)
				echo "Unknown input! Please choose Y or N\n";;
		esac
	done
else
	_install
fi