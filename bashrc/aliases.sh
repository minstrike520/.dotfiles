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

aliases-check() {
  cat $HOME/.dotfiles/bashrc/aliases.sh
}

alias f='cd "$(fd --type d --hidden --exclude .git --exclude node_module --exclude node_modules --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .vscode-server --exclude .vscode --exclude go/pkg/mod --exclude .local/share/nvim --exclude .cargo/registry --exclude .rustup/toolchains --exclude .yarn --exclude .config/Code --exclude .antigravity --exclude .zig-cache --exclude .local/share/klipper --exclude .SynologyDrive --exclude .local/share/osu --exclude .wine --exclude .var --exclude .local/share/zed --exclude sketchbook --exclude curseforge --exclude .local/share/pnpm --exclude Trash --exclude CacheStorage --exclude "Code Cache" --exclude Cache --exclude .config/Antigravity --exclude ".config/Code - Insiders" --exclude ".config/Code" --exclude .local/share/nvim  | fzf)"'

alias groot='cd "$(git rev-parse --show-toplevel)"'
alias pdlogin='pd login archlinux --user bladeisoe --shared-tmp --termux-home'

alias ztar="tar -I \"zstd -T0 --long -v\""

alias docpan='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) ghcr.io/minstrike520/pandoc-docker:main'
