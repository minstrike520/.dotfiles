CLI_ESSENTIALS="git github-cli vim nvim htop less tree rustup dust ntfs-3g unrar man-db stow openssh zip unzip wget bash-completion"
GUI_ESSENTIALS="plasma sddm noto-fonts noto-fonts-cjk ttf-jetbrains-mono-nerd wl-clipboard"
GUI_IM="fcitx5 fcitx5-chewing fcitx5-qt fcitx5-gtk fcitx5-configtool fcitx5-anthy"

GUI_APPS="konsole kate kwrite dolphin filelight tlp viewnior openbsd-netcat partitionmanager dosfstools vlc alsa-utils kdeconnect"

# ---

AUR_APPS="google-chrome envycontrol onlyoffice-bin visual-studio-code-bin pacseek obsidian-bin tlpui ttf-genryu-git"

alias dotinst-sync="sudo pacman -S --needed"

dotinst-set-locale() {
  sudo sed -i '/^#zh_TW.UTF-8 UTF-8$/s/^#//' /etc/locale.gen
  sudo locale-gen
}

dotinst-gui() {
  pacman -S $GUI_ESSENTIALS
  pacman -S $GUI_IM
  sudo systemctl enable --now sddm
}

dotinst-aur() {
  cd ~/
  git clone https://aur.archlinux.org/yay.git
  cd yay/
  makepkg -si || return 1
  rm -rf ~/yay
}

dotinst-full() {

sudo pacman -Syu
sudo pacman -S $CLI_ESSENTIALS
inst-gui
sudo pacman -S $GUI_APPS
inst-aur
yay -S $AUR_APPS
gh auth login --web --git-protocol https
~/.dotfiles/install.sh

}
