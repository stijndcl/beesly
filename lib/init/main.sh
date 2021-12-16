#!/bin/sh

LOC="${BASH_SOURCE%/*}"
CONFIGDIR=$HOME/.beesly

# Create .beesly dir
mkdir -p "${CONFIGDIR}/"

# Create .beeslyrc file
touch "${CONFIGDIR}/.beeslyrc"

# Create python venv
echo -n "Creating Python venv... "
cd $CONFIGDIR
python3 -m venv venv
echo "Done"