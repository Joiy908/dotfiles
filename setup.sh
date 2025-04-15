#!/bin/bash

# Define colors
BLUE=$(tput setaf 14)
RED=$(tput setaf 9)
NC=$(tput sgr0)

# Error checking function
check() {
  if [ $? -ne 0 ]; then
    echo "${RED}$1${NC}"
    exit 1
  fi
}

# Detect distribution
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO=$ID
else
  echo "${RED}Cannot determine distribution${NC}"
  exit 1
fi

# Package manager setup
if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
  PKG_INSTALL="sudo apt install -y"
  PKG_UPDATE="sudo apt update"
  PKG_UPGRADE="sudo apt upgrade -y"
elif [[ "$DISTRO" == "arch" ]]; then
  PKG_INSTALL="sudo pacman -S --noconfirm"
  PKG_UPDATE="sudo pacman -Syu --noconfirm"
  PKG_UPGRADE="sudo pacman -Syu --noconfirm"
else
  echo "${RED}Unsupported distribution: $DISTRO${NC}"
  exit 1
fi

# Define stages
stages=(
  "Install Git"
  "Clone dotfile repo"
  "Set up vim, bash, fish, tmux dotfiles"
  "Set up Neovim dotfiles"
  "Change package source and update programs"
  "Install Python3 and essential packages"
  "Install fish shell"
  "Install Neovim"
  "Install vim-plug for Neovim"
)

# Display stages
echo "Please input the stages you want to run (e.g., 1235, or -a for all):"
for i in "${!stages[@]}"; do
  echo "$((i+1)): ${stages[$i]}"
done

# Read user input
read -p "Stages: " input

# Function to check if a stage is selected
is_selected() {
  [[ $input == *$1* ]] || [[ $input == "-a" ]]
}

# Generate sources.list for Ubuntu/Debian
generate_sources_list() {
  if [[ "$version" == "jammy" ]]; then
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
  $PKG_INSTALL git
  check "Failed to install Git"
fi

if is_selected 2; then
  echo "== Clone dotfile repo"
  git clone --depth=1 git@github.com:Joiy908/dotfiles.git
  if [ $? -ne 0 ]; then
    git clone --depth=1 https://gitee.com/joiy908/dotfiles.git
    check "Failed to clone"
  fi
  cd dotfiles
fi

if is_selected 3; then
  echo "== Set up vim, bash, fish, tmux dotfiles"
  # Ensure ~/.config/fish exists
  mkdir -p ~/.config/fish
  # Remove existing files (if any) and create symlinks
  ln -f "files/.vimrc" ~/.vimrc
  ln -f "files/.bashrc" ~/.bashrc
  ln -f "files/config.fish" ~/.config/fish/config.fish
  # Create tmux config
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
  echo "source ~/.vimrc" > ~/.config/nvim/init.vim
fi

if is_selected 5; then
  echo "== Change package source and update programs"
  if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    # Prompt for Ubuntu version
    echo "Choose version of Ubuntu:"
    echo "1) 22.04 (Jammy)"
    echo "2) 20.04 (Focal)"
    read -p "Input (1 or 2): " version_choice
    if [[ $version_choice -eq 1 ]]; then
      version="jammy"
    elif [[ $version_choice -eq 2 ]]; then
      version="focal"
    else
      echo "${RED}Invalid input${NC}"
      exit 1
    fi
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    generate_sources_list | sudo tee /etc/apt/sources.list
    $PKG_UPDATE
    $PKG_UPGRADE
    check "Package source change and update failed"
  elif [[ "$DISTRO" == "arch" ]]; then
    # For Arch, update mirrorlist (optional, using a Chinese mirror as example)
    echo "Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" | sudo tee /etc/pacman.d/mirrorlist
    $PKG_UPDATE
    check "Package update failed"
  fi
fi

if is_selected 6; then
  echo "== Install Python3 and essential packages"
  if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    $PKG_INSTALL python3 python3-dev python3-setuptools
  elif [[ "$DISTRO" == "arch" ]]; then
    $PKG_INSTALL python3 cmake
  fi
  check "Failed to install Python3 and essential packages"
fi

if is_selected 7; then
  echo "== Install fish shell"
  $PKG_INSTALL fish
  check "Failed to install fish shell"
  chsh -s /usr/bin/fish
fi

if is_selected 8; then
  echo "== Install Neovim"
  if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    $PKG_UPDATE
    $PKG_INSTALL neovim python3-neovim build-essential cmake python3-dev g++
  elif [[ "$DISTRO" == "arch" ]]; then
    $PKG_INSTALL neovim python-pynvim
  fi
  check "Failed to install Neovim"
fi

if is_selected 9; then
  echo "== Install vim-plug for Neovim"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  check "Failed to install vim-plug for Neovim"
  echo "In nvim, run :PlugInstall"
  echo "Then:"
  echo "cd ~/.vim/plugged/YouCompleteMe && python3 install.py --clangd-completer"
fi


