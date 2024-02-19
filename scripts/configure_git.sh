#! /usr/bin/zsh

EMAIL="${EMAIL:'-jlukenoff@gmail.com'}"
SSH_KEYFILE=~/.ssh/id_ed25519

git config --global init.defaultBranch main
git config --global user.email "$EMAIL"
git config --global core.editor vim
git config --global pull.rebase true
git config --global push.default simple

if [ "$1" != "--setup-ssh" ] && [ "$1" != "-S" ]; then
    echo "Configured default git configs"
    exit 0
fi


if [ ! -e ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEYFILE"
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEYFILE"
fi

echo "
Paste the following public key into github at https://github.com/settings/ssh/new:
$(cat "$SSH_KEYFILE.pub")
"

github_ssh_conf="
Host github.com
    AddKeysToAgent yes
    IgnoreUnknown UseKeychain
    UseKeychain yes
    IdentityFile $SSH_KEYFILE
"
config_file="$HOME/.ssh/config"

if [ ! -e "$config_file" ]; then
    touch "$config_file"
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*
fi

if ! grep -qF "$github_ssh_conf" "$config_file"; then
    echo "$github_ssh_conf" >> "$config_file"
else
    echo "Github ssh conf already present in ~/.ssh/config"
fi
