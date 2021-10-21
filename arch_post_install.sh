#!/bin/sh

#  Login as user and run this script

sudo pacman -S --noconfirm rsync 

git clone --separate-git-dir=$HOME/.dotfiles https://github.com/bugswriter/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles

# Installing programs from main package repo
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db xwallpaper python-pywal youtube-dl unclutter xclip maim \
     zip unzip unrar p7zip xdotool \
     dosfstools ntfs-3g git \
     vim emacs arc-gtk-theme rsync \
     xcompmgr libnotify dunst slock 
     
# Compiling programs from source code
git clone --depth=1 https://github.com/Bugswriter/dwm.git ~/.local/src/dwm
sudo make -C ~/.local/src/dwm install

git clone --depth=1 https://github.com/Bugswriter/st.git ~/.local/src/st
sudo make -C ~/.local/src/st install

git clone --depth=1 https://github.com/Bugswriter/dmenu.git ~/.local/src/dmenu
sudo make -C ~/.local/src/dmenu install

git clone --depth=1 https://github.com/Bugswriter/baph.git ~/.local/src/baph
sudo make -C ~/.local/src/baph install

# AUR installs
baph -inN libxft-bgra-git brave-bin 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/zsh/oh-my-zsh
rm ~/.zshrc ~/.zsh_history
