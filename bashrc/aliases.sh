#
# aliases.sh
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias gitlog='git log --oneline --decorate --all --graph'
alias yay='yay --answeredit=None --answerdiff=None --removemake=None --answerclean=None'
alias ffind='find . -iname'
alias edit='nvim'
alias klear='printf "\E[H\E[3J"'
alias nivm='nvim'
alias sdat='systemctl status'
alias sdop='sudo systemctl stop'
alias sdart='sudo systemctl start'
alias sden='sudo systemctl enable'
alias sdis='sudo systemctl disable'
alias sdres='sudo systemctl restart'
alias op='xdg-open'

aliases-check() {
  cat $HOME/.dotfiles/bashrc/aliases.sh
}
