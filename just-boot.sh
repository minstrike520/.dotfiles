# Set Locale
sudo sed -i '/^#zh_TW.UTF-8 UTF-8$/s/^#//' /etc/locale.gen
sudo locale-gen

# System Specifications
# TODO

# Applications
sudo pacman -Syu
## CLI
sudo pacman -S git github-cli vim nvim htop less tree rustup dust ntfs-3g unrar man-db stow openssh zip unzip wget bash-completion
## GUI Essentials
sudo pacman -S plasma sddm noto-fonts noto-fonts-cjk ttf-jetbrains-mono-nerd wl-clipboard

## Input methods
sudo pacman -S fcitx5 fcitx5-chewing fcitx5-qt fcitx5-gtk fcitx5-configtool fcitx5-anthy

sudo systemctl enable --now sddm

## GUI Apps
sudo pacman -S konsole kate kwrite dolphin filelight tlp viewnior openbsd-netcat partitionmanager dosfstools vlc alsa-utils   kdeconnect

# AUR Applications
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
yay -Sy
## GUI Essentials
yay -S --noconfirm --answerdiff=None --answeredit=None google-chrome envycontrol onlyoffice-bin visual-studio-code-bin pacseek obsidian-bin tlpui ttf-genryu-git # fontweak (2025-09-14: Official source code doesn't build)
## GUI Additional
yay -S --noconfirm --answerdiff=None --answeredit=None mindustry-bin

yay -S --noconfirm --answerdiff=None --answeredit=None anthy-unicode kasumi-unicode

# gh auth login --web --git-protocol https
