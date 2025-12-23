#!/bin/bash

cd $(dirname "$0")/stow

GETOPT_ARGS=`getopt --options f --long force -n "$0" -- "$@"`

eval set -- "${GETOPT_ARGS}"

stow_flags="--verbose"

while true; do
  case "$1" in
    -f|--force)
      echo "Are you sure to override the existing files in the file system (if any)?"
      read
      f_force=true
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
  targets=$(ls -A)
else
  targets=$@
fi

for target in $targets; do
  if [[ $f_force ]]; then
    pushd $target > /dev/null
    target_contents=$(ls -A)
    echo ====RM TARGET \($target\) :====
    for content in $target_contents; do
      echo $HOME  / $content
    done
    echo ========
    echo
    popd > /dev/null
  fi
done

echo
echo "CHECK AGAIN! IF YOU PROCEED, THE FILE ABOVE WILL BE ERASED."
echo
read

for target in $targets; do
  echo ====STOW TARGET \($target\) :====
  if [[ $f_force ]]; then
    pushd $target > /dev/null
    target_contents=$(ls -A)
    for content in $target_contents; do
        rm -r $HOME/$content
    done
        popd > /dev/null
  fi
  stow -d ./ -t $HOME/ $target $stow_flags
  echo ========
  echo 
done
