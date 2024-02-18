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

echo "
The next steps will generate an ssh key to let us authenticate with git over ssh.
Follow the prompts and paste the output into GitHub at https://github.com/settings/ssh/new
"


if [ ! -e ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEYFILE"
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEYFILE"
fi

echo "
Paste your current public key to github:
$(cat "$SSH_KEYFILE.pub")
"

github_ssh_conf="
Host github.com
  AddKeysToAgent yes
  IdentityFile "$SSH_KEYFILE"
"
config_file="$HOME/.ssh/config"

if [ ! -e "$config_file" ]; then
    touch "$config_file"
fi

if ! grep -qF "$github_ssh_conf" "$config_file"; then
    echo "$github_ssh_conf" >> "$config_file"
else
    echo "Github ssh conf already present in ~/.ssh/config"
fi
