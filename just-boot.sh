# Set Locale
sudo sed -i '/^#zh_TW.UTF-8 UTF-8$/s/^#//' /etc/locale.gen
sudo locale-gen

# System Specifications
# TODO

# Applications
sudo pacman -Syu
## CLI Essentials
sudo pacman -S git github-cli vim nvim kdeconnect less tree dust unrar man-db stow openssh zip unzip wget
sudo pacman -S --needed base-devel

## CLI Additional
# sudo pacman -S ntfs-3g rustup

## GUI Essentials
sudo pacman -S plasma sddm konsole kate kwrite dolphin filelight tlp viewnior openbsd-netcat partitionmanager vlc alsa-utils ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk
## GUI Additional
sudo pacman -S dosfstools

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

# Input methods
sudo pacman -S fcitx5 fcitx5-chewing fcitx5-qt fcitx5-gtk fcitx5-configtool

yay -S --noconfirm --answerdiff=None --answeredit=None anthy-unicode kasumi-unicode

sudo pacman -S fcitx5-anthy

# gh auth login --web --git-protocol https

sudo systemctl enable --now sddm
