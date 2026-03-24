#
# aliases.sh
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias gitlog='git log --oneline --decorate --all --graph'
# alias paru='paru --noansweredit --noanswerdiff --noremovemake --noanswerclean'
alias ffind='find . -iname'
alias edit='nvim'
alias klear='printf "\E[H\E[3J"'
alias aur='pacseek -s'
alias myps='LANG= ps auxf | cut -c 1-$COLUMNS'
alias hjust='just --justfile ~/.dotfiles/Justfile'
alias nivm='nvim'
alias op='xdg-open'

alias sdat='systemctl status'
alias sdop='sudo systemctl stop'
alias sdart='sudo systemctl start'
alias sden='sudo systemctl enable'
alias sdis='sudo systemctl disable'
alias sdres='sudo systemctl restart'

aliases-check() {
  cat $HOME/.dotfiles/bashrc/aliases.sh
}

alias f='cd $(fd --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv | fzf)'

alias groot='cd "$(git rev-parse --show-toplevel)"'
