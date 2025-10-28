cd $(dirname "$0")/stow

if [[ "$#" -eq 1 ]]; then
  echo this path
  stow --verbose -d ./ -t ~/ $1
else
  echo that path
  stow -d ./ -t ~/ */
fi
