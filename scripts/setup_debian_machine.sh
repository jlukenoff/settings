#! /bin/sh

set -e

# Get the local directory of this file
DIR="$( dirname $(realpath "$0"))"

sudo apt-get update -y
sudo apt-get upgrade -y

# Install some other useful tools
sudo apt install -y \
    git \
    tmux \
    python3-pip \
    fzf \
    tree \
    zsh

if [ ! -d ~/.oh-my-zsh]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed, skipping..."
fi

## Make zsh the default for tmux
echo "set-option -g default-shell /bin/zsh" > /etc/tmux.conf


# Install a good vim config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Set the path to the zshrc file
zshrc_path=~/.zshrc

# Set the path to the aliases file
zsh_extras_path=$DIR/../config/zshrc
zsh_aliases_path=$DIR/../config/aliases

cat "$zsh_extras_path" >> "$zshrc_path"
cat "$zsh_aliases_path" >> ~/.zsh_aliases

chsh $(whoami) -s $(which zsh)

/bin/zsh
