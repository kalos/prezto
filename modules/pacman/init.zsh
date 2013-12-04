#
# Defines Pacman aliases.
#
# Authors:
#   Benjamin Boudreau <dreurmail@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Tips:
#   https://wiki.archlinux.org/index.php/Pacman_Tips
#

# Return if requirements are not found.
if (( ! $+commands[pacman] )); then
  return 1
fi

#
# Frontend
#

# Get the Pacman frontend.
zstyle -s ':prezto:module:pacman' frontend '_pacman_frontend'

if (( $+commands[$_pacman_frontend] )); then
  alias pacman="$_pacman_frontend"

  if [[ -s "${0:h}/${_pacman_frontend}.zsh" ]]; then
    source "${0:h}/${_pacman_frontend}.zsh"
  fi
fi

#
# Aliases
#

# Installs packages from repositories.
alias Pi='sudo pacman --sync'

# Installs packages from files.
alias Pif='sudo pacman --upgrade'

# Removes packages.
alias Pr='sudo pacman --remove'

# Removes packages, their configuration, and unneeded dependencies.
alias PR='sudo pacman --remove --nosave --recursive'

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias Pu='sudo pacman --sync --refresh --sysupgrade'

# Synchronizes the local package and Arch Build System databases against the
# repositories then upgrades outdated packages.
if (( $+commands[abs] )); then
  alias Pu='sudo pacman --sync --refresh && sudo abs'
fi

# Searches for packages.
alias Ps='pacman --sync --search'

# Searches for packages in the local database.
alias Psl='pacman --query --search'

# Displays information about a package from the repositories.
alias Pinf='pacman --sync --info'

# List files installed to your system from package.
alias PL='pacman --query --list'

# Cleans the cache.
alias Pc='pacman -Scc --noconfirm'

# Lists orphan packages.
alias pacman-list-orphans='sudo pacman --query --deps --unrequired'

# Removes orphan packages.
alias pacman-remove-orphans='sudo pacman --remove --recursive $(pacman --quiet --query --deps --unrequired)'

unset _pacman_frontend

