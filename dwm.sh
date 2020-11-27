# Pacman Install
sudo pacman --noconfirm -S zsh python-pywal dmenu git picom ttf-hack ttf-joypixels noto-fonts noto-fonts-cjk noto-fonts-emoji xdotool
git clone https://github.com/PandaFoss/baph.git
cd baph
sudo make install
cd ..

# BuildingSuckless
git clone https://github.com/bugswriter/mydwm.git
cd mydwm
sudo make clean install
cd ..
git clone https://github.com/bugswriter/myst.git
cd myst
sudo make clean install
cd ..
git clone https://github.com/bugswriter/dwmblocks.git
cd dwmblocks
sudo make clean install

# xinitrc stuff bitch
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i -r '/^\s*$/d' ~/.xinitrc
echo "dwmblocks &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "setbg ~/.config/wall.png" >> ~/.xinitrc
echo "while true; do" >> ~/.xinitrc
echo "  exec dwm >/dev/null 2>&1" >> ~/.xinitrc
echo "done" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/random/alanpeabody/g' ~/.zshrc
echo "PATH='/home/raj/.local/bin:$PATH'" >> ~/.xinitrc
