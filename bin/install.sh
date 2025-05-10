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

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-h|--help)
				usage;exit 0;;
			--bash)
				bash="true";;
			
			*)
				;;
		esac
		shift
	done
	
	# update pacman
	# pacman -Syu --noconfirm

	# check if zsh exists
	if !(type "zsh" > /dev/null 2>&1); then
		pacman -S --noconfirm zsh
	else
		echo "already exists zsh."
	fi
	
}

main "$@"
