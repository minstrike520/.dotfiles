#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# export RED="\033[0;91m"
# export GREEN="\033[0;92m"
# export YELLOW="\033[0;93m"
# export BLUE="\033[0;94m"
# export RESET="\033[0m"

echo_info() {
  echo -e "${BLUE}[INFO]${RESET} $@"
}

echo_warn() {
  echo -e "${YELLOW}[WARN]${RESET} $@"
}

echo_error() {
  echo -e "${RED}[ERROR]${RESET} $@"
}

export -f echo_info
export -f echo_warn
export -f echo_error

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
safe_source "$BASH_CONFIG_DIR/de_specific.sh"

if [[ -v TERMUX_VERSION ]]; then
  export LANG="en_US.UTF-8"
fi
if grep -q "Raspberry Pi" /proc/cpuinfo; then
  alias temp="vcgencmd measure_temp"
fi

# Get peripheral ENV
safe_source "$HOME/.peripherals.sh"

if [[ ! -n "$DEV_NAME" ]]; then
  echo_warn ".bashrc: \$DEV_NAME is not set."
  return
fi

if [[ "$DEV_NAME" == "laptop" ]]; then
  # ALSA special setup for my laptop
  export ALSA_CARD=CMQ3
fi
if [[ "$DEV_NAME" == "MiPad" ]]; then
  unset LD_PRELOAD
fi
