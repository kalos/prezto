#
# Sets directory options and defines directory aliases.
#
# Authors:
#   James Cox <james@imaj.es>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Options
#

setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to ~ list.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt CHASE_DOTS           # foo/bar/.. isn't foo/ even if bar is a symlink.
setopt CHASE_LINKS          # cd to a symlink is in fact cd to the true dir.

#unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
#                            # Use >! and >>! to bypass.

#
# Aliases
#

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias -- -="cd -"

hash -d L=/usr/src/linux/
hash -d VL=/var/log
hash -d V=~/.vim/
hash -d DOC=/home/kalos/doc

