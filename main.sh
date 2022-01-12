#!/bin/sh
LOC="${BASH_SOURCE%/*}"
CONFIGDIR=$HOME/.beesly

# Init directories if they don't exist
if [ ! -d $HOME/.beesly ]
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

# Python scripts: activate beesly venv first
function run-python() {
    # Name of the script's directory
    SCRIPTNAME=$1
    shift

    # Activate venv
    source "${CONFIGDIR}/venv/bin/activate"

    # Call script & pass all args
    python3 "${LOC}/lib/${SCRIPTNAME}/main.py" "$@"
}

# Store command & shift it out
COMMAND=$1
shift

case $COMMAND in
    http|request|fetch)
        run-python "http" "$@"
        exit 0
        ;;
    ignore|gitignore)
        run-python "ignore" "$@"
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