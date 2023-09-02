

```bash
# for ubuntu20.04
sudo apt install git # if fails, change the sources.list first

git clone --depth=1 git@github.com:Joiy908/dotfiles.git

# move dotfiles
rm ~/.vimrc ~/.bashrc
ln dotfiles/.vimrc ~/.vimrc
ln dotfiles/.bashrc ~/.bashrc

mkdir -p ~/.config/fish
rm ~/.config/fish/config.fish
ln dotfiles/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.vim
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
chsh -s /usr/bin/fish

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get install -y neovim
# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#in nvim :PlugInstall
#then
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clangd-completer

```

