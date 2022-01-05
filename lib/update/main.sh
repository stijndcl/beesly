#!/bin/sh

LOC="${BASH_SOURCE%/*}"

function match() {
    sudo apt update
    sudo apt install $1
}

# No args provided, update beesly itself
if [[ $# -eq 0 ]]
then
    cd $LOC

    # Pull repo
    git pull

    # Update python requirements
    pip3 install -r lib/requirements.txt
    
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