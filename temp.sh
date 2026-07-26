if [[ -v TERMUX_VERSION ]]; then
  export LANG="en_US.UTF-8"
fi
if grep -q "Raspberry Pi" /proc/cpuinfo; then
  alias temp="vcgencmd measure_temp"
  alias fd="fdfind"
  export PATH="$PATH:/opt/nvim/:/opt/zellij/"
fi

if [[ -v KITTY_WINDOW_ID ]]; then
  alias ssh="kitten ssh"
fi

# Get peripheral ENV
source "$HOME/.peripherals.sh"

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
