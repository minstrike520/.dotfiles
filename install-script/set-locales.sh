sudo sed -i -e '/^#zh_TW.UTF-8 UTF-8$/s/^#//' -e '/^#en_US.UTF-8 UTF-8$/s/^#//' /etc/locale.gen
sudo locale-gen
