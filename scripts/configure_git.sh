#! /usr/bin/zsh

EMAIL="${EMAIL:-'jlukenoff@gmail.com'}"

git config --global init.defaultBranch main
git config --global user.email "$EMAIL"
git config --global core.editor vim


echo "
The next steps will generate an ssh key to let us authenticate with git over ssh.
Following the prompts and past the output into github at https://github.com/settings/ssh/new
"

if [ ! -e ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "$EMAIL"
fi

github_ssh_conf="Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
"
config_file="~/.ssh/config"

if [ ! -e "$config_file" ]; then
    touch "$config_file"
fi

if ! grep -qF "$github_ssh_conf" "$config_file"; then
    echo $github_ssh_conf >> "$config_file"
else
    echo "Github ssh conf already present in ~/.ssh/config"
fi

