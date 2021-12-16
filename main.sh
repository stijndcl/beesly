#!/bin/sh
LOC="${BASH_SOURCE%/*}"

# Init directories if they don't exist
if [ ! -d ~/.beesly ]
then
    echo "First use, initializing config files & directories..."
    bash "${LOC}/lib/init/main.sh"
fi

# No args provided
if [[ $# -eq 0 ]]
then
    echo "Yes, $USER?"
    exit 1;
fi

# Store command & shift it out
COMMAND=$1
shift

case $COMMAND in
    ignore|gitignore)
        bash "${LOC}/lib/ignore/main.sh" "$@"
        exit 0
        ;;
    install|fix)
        bash "${LOC}/lib/install/main.sh" "$@"
        exit 0
        ;;
    parrot)
        bash "${LOC}/lib/parrot/main.sh"
        exit 0
        ;;
    update)
        bash "${LOC}/lib/update/main.sh" "$@"
        exit 0
        ;;
    *)
        echo "Unknown command ${COMMAND}."
        exit 1
        ;;
esac