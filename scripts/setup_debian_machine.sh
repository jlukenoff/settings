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
sudo sh -c "echo 'set-option -g default-shell /bin/zsh' >> /etc/tmux.conf"

# Install a good vim config
if [ -d ~/.vim_runtime ]; then
    echo "vim_runtime already installed, skipping..."
else
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# Set the path to the aliases file
zsh_extras_path=$DIR/../configs/zshrc
zsh_aliases_path=$DIR/../configs/aliases

cat "$zsh_extras_path" >> ~/.zshrc

# check if ~/.zshrc already containts the contents of $zsh_aliases_path, if not, append it
if ! grep -qF "$zsh_extras_path" ~/.zshrc; then
    echo "source $zsh_extras_path" >> ~/.zshrc
else
    echo "ZSH extras already present in ~/.zshrc"
fi

if ! grep -qF "$zsh_aliases_path" ~/.zsh_aliases; then
    echo "source $zsh_aliases_path" >> ~/.zsh_aliases
else
    echo "Aliases already present in ~/.zsh_aliases"
fi



chsh $(whoami) -s $(which zsh)

$DIR/configure_git.sh

/bin/zsh

