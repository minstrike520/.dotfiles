#
# git.fish
#

set GIT_PAGER ""

alias gitlog='git log --oneline --decorate --all --graph'
alias groot='cd "$(git rev-parse --show-toplevel)"'
