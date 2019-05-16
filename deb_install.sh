#!/bin/bash

# Install environment
sudo apt -y install vim x-window-system i3 git curl vim-gtk locate; 
echo 'exec i3' > ~/.xinitrc;
echo 'xrdb ~/.Xresources' >> ~/.xinitrc;

# Load x-settings
wget --no-check-certificate --no-cache -O ~/.vimrc https://raw.githubusercontent.com/Xatenev/x-settings/master/.vimrc

wget --no-check-certificate --no-cache -O ~/.Xresources https://raw.githubusercontent.com/Xatenev/x-settings/master/.Xresources

wget --no-check-certificate --no-cache -O ~/.config/i3/config https://raw.githubusercontent.com/Xatenev/x-settings/master/config

xrdb ~/.Xresources
# Install browser

if [ -f "chrome.deb" ]; then
	wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

	sudo apt -y install ./chrome.deb
fi

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
source ~/.bashrc


# next steps:
# startx
# sudo su root
# dpkg-reconfigure keyboard-configuration 
# choose german no dead keys here and generic intel 105 key
# udevadm trigger --subsystem-match=input --action=change
# service keyboard-setup restart
