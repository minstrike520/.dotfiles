#
# aliases.fish
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias gitlog='git log --oneline --decorate --all --graph'
alias dockerps='docker ps --format "{{.Names}}\t{{.Image}}\t{{.Status}}"'
# alias paru='paru --noansweredit --noanswerdiff --noremovemake --noanswerclean'
alias ffind='find . -iname'
alias edit='nvim'
alias klear='clear && printf "\E[H\E[3J"'
alias kshutdown="qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logoutAndShutdown"
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


alias groot='cd "$(git rev-parse --show-toplevel)"'
alias pdlogin='pd login archlinux --user bladeisoe --shared-tmp --termux-home'

alias ztar="tar -I \"zstd -T0 --long -v\""

alias docpan='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) ghcr.io/minstrike520/pandoc-docker:main'
