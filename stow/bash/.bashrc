#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

echo_warn() {
  echo -e "${YELLOW}[WARN]${RESET} $@"
}

echo_error() {
  echo -e "${RED}[ERROR]${RESET} $@"
}

safe_source() {
  if [ -f "$1" ]; then
    source "$1"
  else
    echo_warn ".bashrc: safe_source: $1: No such file or directory"
  fi
}

BASH_CONFIG_DIR="$HOME/.dotfiles/bashrc"

safe_source "$BASH_CONFIG_DIR/variables.sh"
safe_source "$BASH_CONFIG_DIR/aliases.sh"
safe_source "$BASH_CONFIG_DIR/utils.sh"

# Get peripheral ENV
safe_source "$HOME/.peripherals.sh"

if [[ ! -n "$DEV_NAME" ]]; then
  echo_warn ".bashrc: \$DEV_NAME is not set."
  return
fi

if [[ "$DEV_NAME" == "laptop" ]]; then
  # ALSA special setup for my laptop
  export ALSA_CARD=CMQ3
  safe_source "$BASH_CONFIG_DIR/de_specific.sh"
elif [[ "$DEV_NAME" == "MiPad" ]]; then
  export LANG="en_US.UTF-8"

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
