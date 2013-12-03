#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'helper' 'spectrum'

# Correct commands.
setopt CORRECT

#
# Aliases
#

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'

# Disable globbing.
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'
alias git='noglob git'

# Define general aliases.
alias _='sudo'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'

# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if zstyle -t ':prezto:module:utility:ls' color; then
    if [[ -s "$HOME/.dir_colors" ]]; then
      eval "$(dircolors "$HOME/.dir_colors")"
    else
      eval "$(dircolors)"
    fi

    alias ls="$aliases[ls] --color=auto"
  else
    alias ls="$aliases[ls] -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':prezto:module:utility:ls' color; then
    # Define colors for BSD ls.
    export LSCOLORS='exfxcxdxbxGxDxabagacad'

    # Define colors for the completion system.
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

    alias ls='ls -G'
  else
    alias ls='ls -F'
  fi
fi

alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lhA'       # Lists human readable sizes, hidden files.
alias L='ls -lh'         # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# Redirections & Pipes
alias -g N="&>/dev/null"
alias -g 1N="1>/dev/null"
alias -g 2N="2>/dev/null"
alias -g DN="/dev/null"
alias -g Il="| less"
alias -g Ill="2>&1 | less"
alias -g G="| grep -i"
alias -g S="| sort"
alias -g C="| wc -l"


# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
else
  alias o='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# File Download
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then
  alias top=htop
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi

# Miscellaneous

alias vi="vim"

alias s='ssh'
alias Ps='ssh -MNf'

#ssh & scp without security checks
alias ssh-noverify='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias scp-noverify='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

alias iodrag='ionice -c3 nice -n19'

alias netlisteners='lsof -i -P -n | grep LISTEN'

alias d2u='sed "s/.$//"'
alias u2d='sed "s/$/`echo r`/"'
#alias clear="tput reset"
alias clear="echo -ne '\033c'"
alias rmvoid="rm -i *(.L0)"

alias T="tail -f "
alias xprop_name='xprop | grep --color=none "WM_WINDOW_ROLE\|WM_CLASS"'

# quick&dirty mirror
alias mirror="noglob wget --mirror --no-parent --recursive --timestamping --continue --recursive $1"

# Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

#
# Functions
#

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

function any() {
        if [[ -z "$1" ]] ; then
                echo "any - grep for process(es) by keyword" >&2
                echo "Usage: any <keyword>" >&2 ; return 1
        else
                local STRING=$1
                local LENGTH=$(expr length $STRING)
                local FIRSCHAR=$(echo $(expr substr $STRING 1 1))
                local REST=$(echo $(expr substr $STRING 2 $LENGTH))
                ps xauwww| grep "[$FIRSCHAR]$REST"
        fi
}

# Find all suid files in $PATH
function findsuid()
{               
        sudo find / -type f \( -perm -4000 -o -perm -2000 \) -ls > ~/.suid/suidfiles.`date "+%Y-%m-%d"`.out 2>&1
        sudo find / -type d \( -perm -4000 -o -perm -2000 \) -ls > ~/.suid/suiddirs.`date "+%Y-%m-%d"`.out 2>&1
#        sudo find / -type f \( -perm -2 -o -perm -20 \) -ls > ~/.suid/writefiles.`date "+%Y-%m-%d"`.out 2>&1
#        sudo find / -type d \( -perm -2 -o -perm -20 \) -ls > ~/.suid/writedirs.`date "+%Y-%m-%d"`.out 2>&1
}

# Recursively delete all .svn dirs
function rm_svn() { 
  find "$@" -name .svn -print0 | xargs -0 rm -rf
}

# provide useful information on globbing
H-Glob() {
echo -e "
/      directories
.      plain files
@      symbolic links
=      sockets
p      named pipes (FIFOs)
*      executable plain files (0100)
%      device files (character or block special)
%b     block special files
%c     character special files
r      owner-readable files (0400)
w      owner-writable files (0200)
x      owner-executable files (0100)
A      group-readable files (0040)
I      group-writable files (0020)
E      group-executable files (0010)
R      world-readable files (0004)
W      world-writable files (0002)
X      world-executable files (0001)
s      setuid files (04000)
S      setgid files (02000)
t      files with the sticky bit (01000)
print *(m-1)          # List files modified today.
print *(a1)           # List files accessed one day ago.
print *(@)            # Print links.
print *(Lk+50)        # List files > 50 Kilobytes.
print *(Lk-50)        # List files < 50 Kilobytes.
print **/*.c          # Recursively list all c files.
print **/*.c~file.c   # List all c files, except file.c
print (foo|bar).*     # List files whos names start foo or bar.
print *~*.*           # 
chmod 644 *(.^x)      # make all non-executable files publically readable
print -l *(.c|.h)     # List all c and header files on their own lines. 
print **/*(g:users:)  # Recursively list files with the group 'users'
echo /proc/*/cwd(:h:t:s/self//) # Analogue of >ps ax | awk '{print $1}'<

noglob zmv -W ??\ * 0??\ *  # move 01 to 001, 02 to 002, etc
"
}

