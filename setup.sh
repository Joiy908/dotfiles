#!/bin/bash

# Define colors
BLUE=$(tput setaf 14)
RED=$(tput setaf 9)
NC=$(tput sgr0)

ask() {
  read -p "${BLUE}$1 (y/n)${NC}" answer
}

check() {
  if [ $? -ne 0 ]; then
    echo "${RED}$1${NC}"
    exit 1
  fi
}

echo "this script is for ubuntu20.04 setup"

# Ask and Install Git
ask "Install Git?"
if [[ $answer = y ]]; then
  sudo apt install git
  check "Failed to install Git"
fi

ask "Clone dotfile repo?"
if [[ $answer = y ]] ; then
  git clone --depth=1 git@github.com:Joiy908/dotfiles.git
  if [ $? -ne 0 ]; then
    git clone --depth=1 https://gitee.com/joiy908/dotfiles.git
    check "Fail to clone"
  fi
  cd dotfiles
fi

# Set up fish configuration
ask "Set up vim,bash,fish dotfiles?"
if [[ $answer = y ]]; then
  # move dotfiles
  rm ~/.vimrc ~/.bashrc
  ln dotfiles/.vimrc ~/.vimrc
  ln dotfiles/.bashrc ~/.bashrc

  mkdir -p ~/.config/fish
  rm ~/.config/fish/config.fish
  ln dotfiles/config.fish ~/.config/fish/config.fish
fi

# Set up Neovim configuration
ask "Set up Neovim dotfiles?"
if [[ $answer = y ]]; then
  mkdir -p ~/.config/nvim
  rm ~/.config/nvim/init.vim
  echo "source ~/.vimrc" > ~/.config/nvim/init.vim
fi

# Change APT source and update programs
ask "Change APT source and update programs?"
if [[ $answer = y ]]; then
  cp ./sources.list /etc/apt
  sudo apt update
  sudo apt upgrade
  check "APT source change and update failed"
fi

# Install Python3 and essential packages
ask "Install Python3 and essential packages?"
if [[ $answer = y ]]; then
  sudo apt-get install -y python-dev python-pip python3-dev
  check "Failed to install Python3 and essential packages"

  sudo apt-get install -y python3-setuptools
  check "Failed to install Python3 and essential packages"

  sudo apt install -y python3-pip
  check "Failed to install Python3 and essential packages"
fi

# Install fish shell
ask "Install fish shell?"
if [[ $answer = y ]]; then
  sudo apt-get install -y fish
  check "Failed to install fish shell"
  chsh -s /usr/bin/fish
fi

# Install Neovim
ask "Install Neovim?"
if [[ $answer = y ]]; then
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get install -y neovim
  check "Failed to install Neovim"
fi

# Install vim-plug for Neovim
ask "Install vim-plug for Neovim?"
if [[ $answer = y ]]; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  check "Failed to install vim-plug for Neovim"
fi

echo "in nvim :PlugInstall"
echo "then"
echo "cd ~/.vim/plugged/YouCompleteMe && python3 install.py --clangd-completer"
