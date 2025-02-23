#!/bin/bash
#installing reflector
sudo pacman -S reflector --needed
sudo reflector --verbose -l 30 -p https --sort rate --save /etc/pacman.d/mirrorlist

#installing apps
paru -S neofetch thunar picom lxappearance rofi xfce4-power-manager polkit-gnome python-psutil mpd python-mpd2 gnome-keyring fzf python-cairo betterlockscreen

#installing fonts
paru -S nerd-fonts-jetbrains-mono noto-fonts noto-fonts-emoji ttf-linux-libertine ttf-dejavu

#installing icons and themes
paru -S papirus-icon-theme

#installing bluetooth
paru -S bluez blueman alsa-utils
sudo systemctl enable bluetooth.service

#installing packages to support ntfs and external drives in thunar
paru -S ntfs-3g gvfs peazip-gtk2-bin

#installing additional apps
paru -S code ymuse google-chrome github-desktop-bin brave preload tlp xfce4-notifyd vlc cronie bcompare flameshot rsync rclone playerctl mpdris2 pavucontrol-git gwenview qt5-styleplugins --needed
sudo systemctl enable tlp
sudo systemctl enable preload

#Installing lightdm themes
paru -S lightdm-webkit2-greeter lightdm-webkit-theme-aether

#installing envycontrol
paru -S envycontrol
sudo envycontrol -s integrated

#cleanup
sudo pacman -Syu
sudo pacman -Rsn $(pacman -Qtdq)
sudo pacman -Scc
paru -Syu
paru -Rns $(paru -Qtdq)
paru --clean
rm -rf ~/.cache/*

#copying configs
cp -r configs/* ~/.config
chmod +x ~/.config/qtile/autostart.sh

#copying other files
cp -r home/* ~/.
cp home/.bashrc ~/.bashrc
chmod +x ~/automation/*
mkdir ~/OnePlace/Music

#setting lockscreen
betterlockscreen -u ~/OnePlace/wallpapers/wallpaper.jpg --fx dim,pixel

#copying touchpad configs
sudo cp etc_X11_xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

#copying cursur & theme
sudo cp -r usr_share_icons/* /usr/share/icons
sudo cp -r usr_share_themes/* /usr/share/themes

#adding wallpaper to lightdm theme
sudo cp -r ~/OnePlace/wallpapers/* /usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether/src/img/wallpapers

sudo cp /etc/environment /etc/environment_backup
echo "XDG_CURRENT_DESKTOP=Unity" | sudo tee -a /etc/environment
echo "QT_QPA_PLATFORMTHEME=gtk2" | sudo tee -a /etc/environment

echo "System will reboot in 3 Sec..."
sleep 3
sudo reboot