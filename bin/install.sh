set -eu

# Usage message
function usage(){
	cat <<EOF
Usage: install.sh <options>...

Options:
--bash: no change login shell to zsh.

--help: how to use.

EOF
}

function main(){

	# bashFlag
	local bash="false"
	local noupdate="false"

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-h|--help)
				usage;exit 0;;
			--bash)
				bash="true";;
			-u|--no-update)
				noupdate="true";;
			
			*)
				;;
		esac
		shift
	done
	
	# update pacman
	if [ "$noupdate" = false ]; then
		sudo pacman -Syu --noconfirm
	fi	

	# check if zsh exists
	if !(type "zsh" > /dev/null 2>&1); then
		sudo pacman -S --noconfirm zsh
	else
		echo "already exists zsh."
	fi

	if [ "$bash" = true ]; then
		echo "Default Login Shell: Bash"
	else
		chsh -s /bin/zsh $USER
		if [ $? == "0" ]; then
			echo "Change Login Shell"
		fi
	fi
	
}

main "$@"
