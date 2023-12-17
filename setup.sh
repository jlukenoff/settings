#!/bin/bash

# detect which os we're running on
dir=$(dirname "$(realpath "$0")")

# Detect if we're running on a debian linux system (e.g. does apt exist?)
if [ -x "$(command -v apt)" ]; then
    # Run the setup script for debian
    "${dir}/scripts/setup_debian_machine.sh"
fi

