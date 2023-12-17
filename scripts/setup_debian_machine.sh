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

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed, skipping..."
fi

## Make zsh the default for tmux
set_tmux_default_shell="set-option -g default-shell /bin/zsh"
if ! grep -qF "$set_tmux_default_shell" /etc/tmux.conf; then
    sudo sh -c "echo 'set-option -g default-shell /bin/zsh' >> /etc/tmux.conf"
else
    echo "Tmux default shell already set"
fi

# Install a good vim config
if [ -d ~/.vim_runtime ]; then
    echo "vim_runtime already installed, skipping..."
else
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# Set the path to the aliases file
use_zsh_extras="source $DIR/../configs/zshrc"
use_zsh_aliases="source $DIR/../configs/aliases"

# check if ~/.zshrc already containts the contents of $zsh_aliases_path, if not, append it
if ! grep -qF "$use_zsh_extras" ~/.zshrc; then
    echo "$use_zsh_extras" >> ~/.zshrc
else
    echo "ZSH extras already present in ~/.zshrc"
fi

if ! grep -qF "$use_zsh_aliases" ~/.zshrc; then
    echo "$use_zsh_aliases" >> ~/.zshrc
else
    echo "ZSH aliases already present in ~/.zshrc"
fi

chsh $(whoami) -s $(which zsh)

$DIR/configure_git.sh

/bin/zsh

