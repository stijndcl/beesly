#!/bin/sh
LOC="${BASH_SOURCE%/*}"

# No args provided
if [[ $# -eq 0 ]]
then
    echo "Nothing to install."
    exit 1;
fi

case $1 in
    react)
        bash "${LOC}/react.sh"
        exit 0
        ;;
    thefuck|fuck)
        bash "${LOC}/thefuck.sh"
        exit 0
        ;;
    vscode)
        exit 0
        ;;
    yarn)
        bash "${LOC}/yarn.sh"
        exit 0
        ;;
    *)
        sudo apt install $1
        exit 0
        ;;
esac