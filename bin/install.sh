set -eu

# Usage message
function usage(){
	cat <<EOF
Usage: install.sh <options>...

Options:
--bash: no change login shell to zsh.

-i | --init: Install Default Settings.

-u | --update: Update pacman.



--help: how to use.

EOF
}

function main(){

	# bashFlag
	local bash="false"
	# update_flag
	local is_update="false"
	# pacman -S installFlag.
	local is_pkg_install="false"

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-h|--help)
				usage;exit 0;;
			--bash)
				bash="true";;
			-u|--update)
				is_update="true"
			-i|--init)
				is_update="true"
				is_pkg_install="true";;
			
			*)
				;;
		esac
		shift
	done
	
	# update pacman
	if [ "$is_update" = true ]; then
		sudo pacman -Syu --noconfirm

		if [ "$is_pkg_install" = true ]; then
			sudo pacman -S --needed --noconfirm - < ../etc/package.list
		else
			read -p "Do you want to install a package from the package.list? (y/N)" ans
			case "$ans" in
				[Yy]*)
					sudo pacman -S --needed --noconfirm - < ../etc/package.list;;
				"" | N*)
					;;
			esac
		fi
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
	fi
	
}

main "$@"
