# Ensure .peripherals.sh uses cross-shell compatible syntax 
# or convert it to .peripherals.fish
if test -f "$HOME/.peripherals.sh"
    source "$HOME/.peripherals.sh"
end

if test -n "$DEV_NAME"
    if test "$DEV_NAME" = "laptop"
        set -gx ALSA_CARD CMQ3
    else if test "$DEV_NAME" = "MiPad"
        set -e LD_PRELOAD
    end
else
    echo_warn "config.fish: \$DEV_NAME is not set."
end

if status is-interactive
  atuin init fish | source

  set -g fish_color_autosuggestion 999999
  bind ctrl-a 'cls' repaint
end
