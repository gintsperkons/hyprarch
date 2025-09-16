#!/bin/bash

clear

ansiArt="
██╗  ██╗██╗   ██╗██████╗ ██████╗  █████╗ ██████╗  ██████╗██╗  ██╗
██║  ██║ ██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║  ██║
███████║  ████╔╝ ██████╔╝██████╔╝███████║██████╔╝██║     ███████║
██╔══██║   ██╔╝  ██╔═══╝ ██╔══██╗██╔══██║██╔══██╗██║     ██╔══██║
██║  ██║   ██║   ██║     ██║  ██║██║  ██║██║  ██║╚██████╗██║  ██║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
"



# ------------------------
# Print ANSI art with delay per character
# ------------------------
TYPE_SPEED=0.002  # seconds per character

while IFS= read -r line; do
    for (( i=0; i<${#line}; i++ )); do
        echo -n "${line:$i:1}"
        sleep $TYPE_SPEED
    done
    echo ""
done <<< "$ansiArt"

sudo pacman -Syu github --noconfirm --needed

# ------------------------
# Branch selection
# ------------------------
BRANCH=${1:-main}   # Use first argument or default to 'main'

# Clone or update repository
TARGET_DIR="$HOME/.local/share/hyprarch"

if [ -d "$TARGET_DIR/.git" ]; then
    echo "Updating existing repo..."
    cd "$TARGET_DIR" || exit
    git fetch origin
    git checkout "$BRANCH"
    git pull origin "$BRANCH"
else
    echo "Cloning branch '$BRANCH'..."
    git clone --branch "$BRANCH" https://github.com/gintsperkons/hyprarch.git "$TARGET_DIR"
    cd "$TARGET_DIR" || exit
fi

# Run install script
bash install.sh