#! /usr/bin/zsh
git config --global init.defaultBranch main
git config --global user.email "jlukenoff@gmail.com"
git config --global user.name "John Lukenoff"


echo "The next steps will generate an ssh key to let us authenticate with git over ssh. Following the prompts and past the output into github at https://github.com/settings/ssh/new"

if [ ! -e ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "jlukenoff@gmail.com"
fi

github_ssh_conf="Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
"
config_file="~/.ssh/config"

if [ ! -e "$config_file" ]; then
    touch "$config_file"
fi

if ! grep -qF "$text_to_add" "$config_file"; then
    echo $github_ssh_conf >> "$config_file"
else
    echo "Github ssh conf already present in ~/.ssh/config"
fi

