#! /bin/sh

sudo apt-get update
sudo apt-get upgrade

# Install some other useful tools
sudo apt install -y \
    git \
    tmux

# Install zsh/oh-my-zsh
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Make zsh the default for tmux
sudo $(echo "set-option -g default-shell /bin/zsh") > /etc/tmux.conf

# Install a good vim config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

