#!/bin/bash

# detect which os we're running on
target_dir="$HOME/.jlukenoff-custom-settings"

clone_repo() {
    if [ ! -d "$dest" ]; then
        git clone --depth=1 https://github.com/jlukenoff/settings-server.git "$target_dir"
    fi
}

# Detect if we're running on a debian linux system (e.g. does apt exist?)
if [ -x "$(command -v apt)" ]; then
    apt install -y git

    clone_repo

    # Run the setup script for debian
    "$target_dir"/scripts/setup_debian_machine.sh
fi

