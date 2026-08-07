#
# git.fish
#

set GIT_PAGER ""

alias gitlog='git log --oneline --decorate --all --graph --color=always | head -n 10'
alias groot='cd "$(git rev-parse --show-toplevel)"'
