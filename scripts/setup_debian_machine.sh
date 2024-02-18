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

## Make zsh the default for tmux
set_tmux_default_shell="set-option -g default-shell /bin/zsh"
if ! grep -qF "$set_tmux_default_shell" /etc/tmux.conf; then
    sudo sh -c "echo 'set-option -g default-shell /bin/zsh' >> /etc/tmux.conf"
else
    echo "Tmux default shell already set"
fi

eval "$DIR/setup_vim.sh"

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

# Check if the default shell is already set to zsh before changing
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Changing default shell to zsh"
    chsh $(whoami) -s $(which zsh)
else
    echo "Default shell already set to zsh"
fi

$DIR/configure_git.sh

/bin/zsh

