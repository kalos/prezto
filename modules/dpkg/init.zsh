#
# Defines dpkg aliases.
#
# Authors:
#   Daniel Bolton <dbb@9y.com>
#   Benjamin Boudreau <boudreau.benjamin@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[dpkg] && ! $+commands[apt-get] )); then
  return 1
fi

#
# Aliases
#

# Installs packages from repositories.
alias Pi='sudo apt-get install'

# Installs packages, without recommends, from repositories.
alias Pi_='sudo apt-get install --no-install-recommends'

# Installs packages, with suggests, from repositories.
alias Pi+='sudo apt-get install --install-suggests'

# Installs packages from files.
alias Pif='sudo dpkg -i'

# Removes packages.
alias Pr='sudo apt-get remove'

# Removes packages, their configuration, and unneeded dependencies.
alias PR='sudo apt-get remove --purge && sudo apt-get autoremove --purge'

# Updates the package lists.
alias Pu='sudo apt-get update'

# Upgrades outdated packages.
alias PU='sudo apt-get update && sudo apt-get dist-upgrade'

# Searches for packages.
if (( $+commands[aptitude] )); then
  alias Ps='aptitude -F "* %p -> %d \n(%v/%V)" --no-gui --disable-columns search'
else
  alias Ps='apt-cache search -n'
fi
alias PS='apt-cache search'

# Displays package information.
alias Pinf='apt-cache show -f'

# List files installed to your system from package.
alias PL='dpkg -L'

# List packages matching given pattern.
alias Pl='dpkg -l'

# Cleans the cache.
alias Pc='sudo apt-get clean && sudo apt-get autoclean'

# Reconfigure a package.
alias Prec='sudo dpkg-reconfigure'

# Creates a basic deb package.
alias deb-build='time dpkg-buildpackage -rfakeroot -us -uc'

# Removes all kernel images and headers, except for the ones in use.
alias deb-kclean='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea) ?not(~n`uname -r`))"'

