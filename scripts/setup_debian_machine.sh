#! /bin/sh

set -e

# Get the local directory of this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

apt-get update -y
apt-get upgrade -y

# Install some other useful tools
apt install -y \
    git \
    tmux \
    python3-pip \
    zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

/bin/zsh
