#!/bin/bash

set -ce

echo "running latest version of the script"

target_dir="$HOME/.jlukenoff-custom-settings"

clone_or_update_repo() {
    if [ ! -d "$target_dir" ]; then
        git clone --depth=1 https://github.com/jlukenoff/settings-server.git "$target_dir"
    else
        echo "Repo already cloned, updating..."
        cd "$target_dir"
        git pull
    fi
}


# Detect if we're running on a debian linux system (e.g. does apt exist?)
if [ -x "$(command -v apt)" ]; then
    sudo apt install git -y

    clone_or_update_repo

    echo "$target_dir"

    # Run the setup script for debian
    "$target_dir"/scripts/setup_debian_machine.sh
fi

