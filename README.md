

```bash
# for ubuntu20.04
sudo apt install git # if fails, change the sources.list first

git clone --depth=1 git@github.com:Joiy908/dotfiles.git

# move dotfiles
rm ~/.vimrc ~/.bashrc
ln dotfiles/.vimrc ~/.vimrc
ln dotfiles/.bashrc ~/.bashrc

mkdir -p ~/.config/fish
ln dotfiles/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim
echo "source ~/.vimrc" > ~/.config/nvim/init.vim


# change apt source and update programs 
cp ./sources.list /etc/apt
sudo apt update
sudo apt upgrade

# Install Python3
sudo apt-get install -y python-dev python-pip python3-dev
sudo apt-get install -y python3-setuptools
sudo apt install -y python3-pip

# install fish
sudo apt-get install -y fish

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get install -y neovim
```

todo: 
- remove self info and make the repo public
- add ctrlp to .vimrc
- change WSL to nvim
- change .bashrc v from vim to nvim
