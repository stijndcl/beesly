from requests import get
from requests.models import Response
import sys


def alias(name: str) -> str:
    """Add support for aliasing to make some names shorter & allow minor mistakes"""

    aliases = {
        "cpp": "c++",
        "jb": "jetbrains",
        "javascript": "node",
        "js": "node",
        "py": "python"
    }

    return aliases.get(name, name)


def correct(name: str) -> str:
    """Fix things thrown away by capitalize() and add special filepaths"""
    corrections = {
        "Jetbrains": "Global/JetBrains"
    }

    return corrections.get(name, name)


def fetch_template(name: str) -> Response:
    return get(f"https://raw.githubusercontent.com/github/gitignore/main/{name}.gitignore")


def main(args, filehandle):
    for template in args:
        # Filename structure: first letter is capitalized
        name = alias(template).capitalize()

        # Some filenames have multiple uppercased letters in one word or are present in subdirectories
        # (eg. /Global/JetBrains)
        name = correct(name)

        if name == "Idea":
            filehandle.write(".idea/\n\n")
        else:
            res = fetch_template(name)

            if res.status_code == 200:
                filehandle.write(f"{res.text}\n")
                continue

            # Error in request
            print(f"Error fetching template for language {name} (status {res.status_code}). Skipping.", file=sys.stderr)


if __name__ == "__main__":
    args = sys.argv[1:]

    # No arguments
    if not args:
        print("No languages or keywords provided.", file=sys.stderr)
        exit(1)

    with open(".gitignore", "a") as gitignore:
        main(args, filehandle=gitignore)
