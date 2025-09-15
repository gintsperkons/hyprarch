#!/bin/bash

clear

sudo pacman -Syu --noconfirm --needed git


git clone https://github.com/gintsperkons/hyprarch.git ~/.local/share/hyprarch

cd ~/.local/share/hyprarch || exit

./install.sh
