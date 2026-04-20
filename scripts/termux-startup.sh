termux-change-repo
termux-setup-storage

cd ~

pkg update
pkg upgrade
pkg install wget neovim git gh termux-services proot proot-distro dust stow clang x11-repo termux-x11-nightly virglrenderer-android which

proot-distro install archlinux

sv-enable sshd

mkdir tmp/
mkdir tmp/fonts/
mkdir tmp/fonts/JetBrainsMono
cd tmp/JetBrainsMono/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
cp JetBrainsMonoNerdFontMono-SemiBold.ttf ~/.termux/font.ttf

proot-distro login archlinux

pacman -Syu

pacman -S sudo

useradd -m bladeisoe
passwd
visudo

exit

proot-distro login archlinux --user bladeisoe

sudo pacman -S pipewire-jack qt6-multimedia-ffmpeg plasma-desktop konsole kscreen
