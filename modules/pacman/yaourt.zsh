#
# Defines Yaourt aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Aliases
#

# Disable color.
if ! zstyle -t ':prezto:module:pacman:yaourt' color; then
  alias pacman='pacman --nocolor'
fi

# Installs packages from repositories.
alias Pi='sudo yaourt --sync'

# Synchronizes the local package database against the repositories the»\n
# upgrades outdated packages, also upgrade AUR and devel packages.
alias PU='sudo yaourt --sync --refresh --sysupgrade --aur --devel'

# Searches for packages.
alias Ps='yaourt -Ss'

# Cleans the cache.
alias Pc='pacman -Scc --noconfirm ; yaourt -Cc'

