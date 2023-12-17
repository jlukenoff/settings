#!/bin/bash

# detect which os we're running on
dir=$(dirname "$(realpath "$0")")

clone_repo() {
    if [ ! -d "$dest" ]; then
        git clone --depth=1 https://github.com/jlukenoff/settings-server.git ~/.settings-server
    fi
}

# Detect if we're running on a debian linux system (e.g. does apt exist?)
if [ -x "$(command -v apt)" ]; then
    sudo apt install -y git

    # Run the setup script for debian
    "${dir}/scripts/setup_debian_machine.sh"
fi

