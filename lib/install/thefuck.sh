#!/bin/sh

# Install thefuck
pip3 install thefuck --user

# Create alias
ALIASDEST="~/.zshrc"

# Use bashrc if user doesn't have zsh
if [ ! -f "~/.zshrc" ]
then
    if [ ! -f "~/.bash_aliases" ]
    then
        ALIASDEST="~/.bashrc"
    else
        ALIASDEST="~/.bash_aliases"
    fi
fi

echo "eval $(thefuck --alias)" >> $ALIASDEST