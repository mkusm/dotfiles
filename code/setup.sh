#!/bin/bash
set -e

sudo apt-get -y update
sudo apt-get -y upgrade

echo "tzdata tzdata/Areas select Europe" > preseed.txt
echo "tzdata tzdata/Zones/Europe select Warsaw" >> preseed.txt
sudo debconf-set-selections preseed.txt
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata keyboard-configuration
rm preseed.txt

sudo apt-get -y install software-properties-common curl apt-transport-https ca-certificates gnupg-agent
sudo apt-get -y update

curl_retry () {
	for i in {1..5}
	do
		curl --connect-timeout 3 --retry 3 --retry-delay 1 --max-time 15 --speed-time 4 --speed-limit 10 $@
		if [ $? -eq 0  ]
		then
			break
		fi
	done
}

## dotfiles ##

mkdir /home/`whoami` -p
cp -r dotfiles/. /home/`whoami`


## PPAs ##

sudo add-apt-repository ppa:fish-shell/release-3 -y
sudo add-apt-repository ppa:jonathonf/vim -y
sudo add-apt-repository ppa:phoerious/keepassxc -y
sudo add-apt-repository ppa:agornostal/ulauncher -y

curl_retry -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

curl_retry -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get -y update


## Apt ##

sudo apt-get -y install kitty fish vim keepassxc ulauncher spotify-client git python3-pip docker-ce docker-ce-cli containerd.io xcape


## kitty ##

# set as default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50


## navi ##
sudo apt-get install -y fzf
curl_retry -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install > navi_install.sh
sudo chmod +x navi_install.sh
sudo ./navi_install.sh


## slack ##
curl_retry -sL https://downloads.slack-edge.com/linux_releases/slack-desktop-4.8.0-amd64.deb -o slack.deb && sudo apt-get -y install ./slack.deb
rm slack.deb

## vim ##
sudo apt-get -y install git vim

# clone vundle into the proper directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vundle plugins
vim +PluginInstall +qall

# YouCompleteMe install
CURRENT_PATH=`pwd`
sudo apt-get -y install build-essential cmake
cd ~/.vim/bundle/YouCompleteMe && python3 install.py && cd $CURRENT_PATH


## fish ##

## set as default shell
sudo chsh -s /usr/bin/fish

## install oh my fish and enter fish
curl_retry -L https://get.oh-my.fish | fish
