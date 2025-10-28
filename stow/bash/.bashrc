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

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias gitlog='git log --oneline --decorate --all --graph'
alias yays='yay -S --noconfirm --answeredit=None --answerdiff=None'

setup_pnpm() {
  export PNPM_HOME="/home/bladeisoe/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
}

if [[ -f ~/THIS_DEVICE ]] && [[ "$(cat ~/THIS_DEVICE)" == "laptop" ]]; then
  # ALSA special setup for my laptop
  export ALSA_CARD=CMQ3

  setup_pnpm
fi

if [[ -f ~/THIS_DEVICE ]] && [[ "$(cat ~/THIS_DEVICE)" == "MiPad" ]]; then
  export LANG="en_US.UTF-8"
  alias osy="cd ~/shortcuts/TheVault; bash simplesync.sh; cd $OLDPWD"

  unset LD_PRELOAD

  export PATH=$PATH:$HOME/.fluttermux/flutter/bin
  export ANDROID=$HOME/.fluttermux/Android/
  export PATH=$ANDROID/platform-tools:$PATH
  export PATH=$ANDROID/cmdline-tools/latest/bin:$PATH
  export PATH=$ANDROID/cmdline-tools/latest:$PATH
  export ANDROID_SDK=$HOME/$ANDROID
  export PATH=$ANDROID_SDK:$PATH
  export JAVA_HOME=$HOME/.fluttermux/jdk-19.0.2
  export PATH=$PATH:$JAVA_HOME/bin
  export _JAVA_OPTIONS=-Djava.io.tmpdir=$PREFIX/tmp
fi
