#!/bin/bash

# linux で動くやつを書く
# distribution
# - ubuntu

# distribution の判別
if   [ -e /etc/debian_version ] ||
        [ -e /etc/debian_release ]; then
    # Check Ubuntu or Debian
    if [ -e /etc/lsb-release ]; then
        # Ubuntu
        command="apt"
    else
        # Debian
        command="apt"
    fi
else
    echo "Your distribution is not supported."
    exit 1
fi

# pyenv install
curl https://pyenv.run | bash
echo "export PATH=\"/home/yryr/.pyenv/bin:$PATH\"" >> ~/.bash_profile
echo "eval \"$(pyenv init -)\""  >> ~/.bash_profile
echo "eval \"$(pyenv virtualenv-init -)\"" >> ~/.bash_profile
source ~/.bash_profile

sudo $command install peco