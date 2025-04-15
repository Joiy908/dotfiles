#!/bin/bash

# Define colors
BLUE=$(tput setaf 14)
RED=$(tput setaf 9)
NC=$(tput sgr0)

check() {
  if [ $? -ne 0 ]; then
    echo "${RED}$1${NC}"
    exit 1
  fi
}

# Define stages
stages=(
  "Install Git"
  "Clone dotfile repo"
  "Set up vim, bash, fish, tmux dotfiles"
  "Set up Neovim dotfiles"
  "Change APT source and update programs"
  "Install Python3 and essential packages"
  "Install fish shell"
  "Install Neovim"
  "Install vim-plug for Neovim"
)

# Display stages
echo "Please input the stages you want to run (e.g., 1235):"
for i in "${!stages[@]}"; do
  echo "$((i+1)): ${stages[$i]}"
done

# Read user input
read -p "Stages: " input

# Function to check if a stage is selected
is_selected() {
  [[ $input == *$1* ]] || [[ $input == "-a" ]]
}

# Prompt user to select Ubuntu version
echo "choose version of Ubuntu ："
echo "1) 22.04 (Jammy)"
echo "2) 20.04 (Focal)"
read -p "input (1 or 2): " version_choice

# 根据用户选择设置版本变量
if [[ $version_choice -eq 1 ]]; then
  version="jammy"
elif [[ $version_choice -eq 2 ]]; then
  version="focal"
else
  echo "invalid input"
  exit 1
fi

generate_sources_list() {
  if [[ $version == "jammy" ]]; then
    cat <<EOF
deb http://mirrors.163.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-backports main restricted universe multiverse
EOF
  else
    cat <<EOF
deb http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
EOF
  fi
}

# Execute selected stages
if is_selected 1; then
  echo "== Install Git"
  sudo apt install git
  check "Failed to install Git"
fi

if is_selected 2; then
  echo "== Clone dotfile repo"
  git clone --depth=1 git@github.com:Joiy908/dotfiles.git
  if [ $? -ne 0 ]; then
    git clone --depth=1 https://gitee.com/joiy908/dotfiles.git
    check "Fail to clone"
  fi
  cd dotfiles
fi

if is_selected 3; then
  echo "== Set up vim, bash, fish, tmux dotfiles"
  rm ~/.vimrc ~/.bashrc
  ln -s $(pwd)/.vimrc ~/.vimrc
  ln -s $(pwd)/.bashrc ~/.bashrc

  #mkdir -p ~/.config/fish
  rm ~/.config/fish/config.fish
  ln -s $(pwd)/config.fish ~/.config/fish/config.fish
  
  cat <<EOF > ~/.tmux.conf
# Display color
set -g default-terminal "screen-256color"
set-option -g set-clipboard on
set -g mouse on
setw -g mode-keys vi
EOF
fi

if is_selected 4; then
  echo "== Set up Neovim dotfiles"
  mkdir -p ~/.config/nvim
  rm ~/.config/nvim/init.vim
  echo "source ~/.vimrc" > ~/.config/nvim/init.vim
fi

if is_selected 5; then
  echo "== Change APT source and update programs"
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
  generate_sources_list | sudo tee /etc/apt/sources.list
  sudo apt update
  sudo apt upgrade
  check "APT source change and update failed"
fi

if is_selected 6; then
  echo "== Install Python3 and essential packages"
  sudo apt-get install -y python-dev python-pip python3-dev
  check "Failed to install Python3 and essential packages"

  sudo apt-get install -y python3-setuptools
  check "Failed to install Python3 and essential packages"

  sudo apt install -y python3-pip
  check "Failed to install Python3 and essential packages"
fi

if is_selected 7; then
  echo "== Install fish shell"
  sudo apt-get install -y fish
  check "Failed to install fish shell"
  chsh -s /usr/bin/fish
fi

if is_selected 8; then
  echo "== Install Neovim"
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get install -y neovim
  check "Failed to install Neovim"
fi

if is_selected 9; then
  echo "== Install vim-plug for Neovim"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  check "Failed to install vim-plug for Neovim"
fi

echo "in nvim :PlugInstall"
echo "then"
echo "cd ~/.vim/plugged/YouCompleteMe && python3 install.py --clangd-completer"
