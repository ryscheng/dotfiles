#!/bin/bash

GITHUB=~/git/github/ryscheng
DOTFILES=~/git/github/ryscheng/dotfiles

### HELPERS ###
#$1 = command
#$2 = package name
function aptInstall {
	if which $1 >/dev/null; then echo $2 " already installed"
	else sudo apt-get install -y $2
	fi
}

#$1 = command
#$2 = package name
function npmInstall {
	if which $1 >/dev/null; then echo $2 " already installed"
	else npm install -g $2
	fi
}

sudo apt-get update
aptInstall git git
aptInstall curl curl

### DOTFILES ###
mkdir -p $GITHUB
cd $GITHUB
if [ -d $DOTFILES ]; then echo "github:dotfiles already cloned"
else 
	git clone http://github.com/ryscheng/dotfiles.git
	ln -s $DOTFILES/.bashrc.linux ~/.bashrc
	ln -s $DOTFILES/.gitconfig.bare ~/.gitconfig
	ln -s $DOTFILES/.gitignore ~/.gitignore
	ln -s $DOTFILES/.tmux.conf ~/.tmux.conf
	ln -s $DOTFILES/.vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc
fi
cd

##### OTHER #####

if which ykpersonalize >/dev/null; then echo "Yubikey tools already installed"
else
	sudo apt-add-repository ppa:yubico/stable
	sudo apt-get update
	sudo apt-get install -y yubikey-personalization-gui yubikey-neo-manager yubikey-personalization
	sudo apt-get install -y scdaemon
fi

##### APT #####
#sudo apt-get dist-upgrade

aptInstall cargo cargo
aptInstall go golang
aptInstall node nodejs 
aptInstall rustc rustc
aptInstall tmux tmux
aptInstall vim vim
aptInstall vlc vlc

aptInstall gpg2 gpgv2
aptInstall gpg-agent gnupg-agent
aptInstall pcsc_scan pcsc-tools
aptInstall pcscd pcscd

##### NPM #####
npmInstall gulp gulp
npmInstall ncu npm-check-updates
