#!/bin/bash

GITHUB=~/git/github/ryscheng
DOTFILES=~/git/github/ryscheng/dotfiles

### HELPERS ###
#$1 = "-f" or "-d" for file or directory
#$2 = target path 
#$3 = link path
function addLink {
	if [ ! $1 $3 ]; then
		echo "linking $3"
		ln -s $2 $3 
	fi
}

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

### INIT ###
sudo apt-get update
aptInstall git git
aptInstall curl curl

### DOTFILES ###
mkdir -p $GITHUB
cd $GITHUB
if [ -d $DOTFILES ]; then echo "github:dotfiles already cloned"
else 
	git clone git@github.com:ryscheng/dotfiles.git
fi
addLink -f $DOTFILES/.bashrc.linux ~/.bashrc
addLink -f $DOTFILES/.gitconfig.bare ~/.gitconfig
addLink -f $DOTFILES/.gitignore ~/.gitignore
addLink -f $DOTFILES/.tmux.conf ~/.tmux.conf
addLink -d $DOTFILES/.vim ~/.vim
addLink -f ~/.vim/vimrc ~/.vimrc
cd

##### YUBIKEY #####
if which ykpersonalize >/dev/null; then echo "Yubikey tools already installed"
else
	sudo apt-add-repository ppa:yubico/stable
	sudo apt-get update
	sudo apt-get install -y yubikey-personalization-gui yubikey-neo-manager yubikey-personalization
	sudo apt-get install -y scdaemon
fi

##### NODE.JS #####
if which nvm >/dev/null; then echo "Node.js already installed"
else
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

##### RUST #####
if which rustup >/dev/null; then echo "Rust already installed"
else
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

##### APT #####
#sudo apt-get dist-upgrade

#aptInstall gparted gparted
aptInstall keychain keychain
aptInstall tmux tmux
aptInstall vim vim

#aptInstall cargo cargo
#aptInstall go golang
#aptInstall node nodejs 
#aptInstall rustc rustc

#aptInstall gpg2 gpgv2
#aptInstall gpg-agent gnupg-agent
#aptInstall pcsc_scan pcsc-tools
#aptInstall pcscd pcscd
#aptInstall vlc vlc

##### NPM #####
#npmInstall gulp gulp
#npmInstall ncu npm-check-updates
