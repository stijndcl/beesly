#!/bin/sh

# No args provided
if [[ $# -eq 0 ]]
then
    echo "No language or keyword provided."
    exit 1;
fi

LANG=$1

function aliases() {
    case $LANG in
        cpp)
            LANG=c++
            ;;
        js|javascript)
            LANG=node
            ;;
        py)
            LANG=python
            ;;
        *)
            ;;
    esac
}

for var in "$@"
do
    LANG=$var

    case $LANG in
        idea|jb|jetbrains|".idea")
            echo ".idea/" >> .gitignore
            # echo "Added \".idea/\" to .gitignore"
            ;;
        *)
            # Look for aliases
            aliases

            LANG=$(echo $LANG | sed -e "s/\b\(.\)/\u\1/")
            template=$(curl "https://raw.githubusercontent.com/github/gitignore/main/${LANG}.gitignore")

            # No result
            if [[ $template == 404* ]]
            then
                printf "\nNo matching template found for \"$1\", skipping argument.\n"
                exit 1;
            fi

            printf "$template\n" >> .gitignore
            ;;
    esac
done