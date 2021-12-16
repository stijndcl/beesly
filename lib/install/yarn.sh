#!/bin/sh

# Check if npm is installed
NPMV=$(npm -v)

if [[ $NPMV == *"not found"* ]]
then
    echo "No npm installation found"
    exit 1;
fi

npm install --global yarn