# update apt and programs
cp ./sources.list /etc/apt
sudo apt update
sudo apt upgrade


# Install Python3
sudo apt-get install -y python-dev python-pip python3-dev
sudo apt-get install -y python3-setuptools
sudo apt install -y python3-pip

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get install -y neovim