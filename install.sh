#!/bin/bash

cd $(dirname "$0")/stow

GETOPT_ARGS=`getopt --options f --long force -n "$0" -- "$@"`

eval set -- "${GETOPT_ARGS}"

stow_flags="--verbose"

while true; do
  case "$1" in
    -f|--force)
      stow_flags="$stow_flags --override .* --adopt"
      echo "Are you sure to override the existing files in the file system (if any)?"
      read
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo $0: Unexpected Error
      exit 1
      ;;
  esac
done

if [[ $# -eq 0 ]]; then
  stow -d ./ -t $HOME/ */ $stow_flags
else
  for target in "$@"; do
    stow -d ./ -t $HOME/ $target $stow_flags
  done
fi
