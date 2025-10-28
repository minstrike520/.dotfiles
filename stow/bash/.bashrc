#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
GREEN="\[\033[0;92m\]"
BLUE="\[\033[0;94m\]"
RESET="\[\033[0m\]"

# Set the PS1 variable
# \u: username
# \h: hostname (short)
# \W: basename of current working directory
# \$: displays '#' if root, '$' otherwise
export PS1="${GREEN}\u@\h${RESET} ${BLUE}\W${RESET}\$ "

# ALSA special setup for my laptop
export ALSA_CARD=CMQ3

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias gitlog='git log --oneline'
alias yays='yay -S --noconfirm --answeredit=None --answerdiff=None'

# pnpm
export PNPM_HOME="/home/bladeisoe/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
