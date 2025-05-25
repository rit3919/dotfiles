set -eu

# Usage message
function usage() {
  cat <<EOF
Usage: install.sh <options>...

Options:
--bash: no change login shell to zsh.

-i | --init: Install Default Settings.

-u | --update: Update pacman.



--help: how to use.

EOF
}

function main() {

  # bashFlag
  local bash="false"
  # update_flag
  local is_update="false"
  # pacman -S installFlag.
  local is_pkg_install="false"

  # bash_backup path
  local backup_directory="bash_backup"

  # config_backup path
  local config_directory="config_backup"

  local dotfiles_path="$HOME/dotfiles"

  while [ "$#" -gt 0 ]; do
    case "$1" in
    -h | --help)
      usage
      exit 0
      ;;
    --bash)
      bash="true"
      ;;
    -u | --update)
      is_update="true"
      ;;
    -i | --init)
      is_update="true"
      is_pkg_install="true"
      ;;

    *) ;;
    esac
    shift
  done

  # update pacman
  if [ "$is_update" = true ]; then
    sudo pacman -Syu --noconfirm

    if [ "$is_pkg_install" = true ]; then
      sudo pacman -S --needed --noconfirm - <$dotfiles_path/config/package.list
    else
      read -p "Do you want to install a package from the package.list? (y/N)" ans
      case "$ans" in
      [Yy]*)
        sudo pacman -S --needed --noconfirm - <$dotfiles_path/config/package.list
        ;;
      "" | N*) ;;
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

    #backup bashfiles
    if [ ! -d $HOME/$backup_directory ]; then
      mkdir $HOME/${backup_directory}
      mv $HOME/.bash* $HOME/$backup_directory
    else
      read -p "Warning: backup files already exists. Do you want to overwrite? (y/N)" ans
      case $ans in
      [Yy]*)
        mv $HOME/.bash* $HOME/$backup_directory
        ;;
      "" | N*)
        echo "please check your backup files"
        exit
        ;;
      esac
    fi

    # Link .zsh
    ln -s $dotfiles_path/zsh/.zshrc $HOME/.zshrc
  fi

  if [ -d $HOME/.config ]; then
    if [ ! -d $HOME/$config_directory ]; then
      mkdir $HOME/$config_directory
      mv $HOME/.config $HOME/$config_directory
    else
      read -p "Warning: .config already exists. Do you wan to overwrite (y/N)" ans
      case $ans in
      [Yy]*)
        mv $HOME/.config $HOME/$config_directory
        ;;
      "" | N*)
        echo "please check your .config direcotry"
        exit
        ;;
      esac
    fi
  fi

  # Link .config
  ln -s $dotfiles_path/config $HOME/.config
}

main "$@"
