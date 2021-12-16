#!/bin/sh

LOC="${BASH_SOURCE%/*}"

function match() {
    sudo apt update
    sudo apt install $1
}

# No args provided
if [[ $# -eq 0 ]]
then
    cd $LOC
    git pull
    exit 0;
fi

case $1 in
    chrome)
        match "google-chrome-stable"
        exit 0
        ;;
    vscode|code|vsc)
        match "code"
        exit 0
        ;;
    *)
        match $1
        exit 0
        ;;
esac