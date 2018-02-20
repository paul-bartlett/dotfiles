#!/bin/sh

# Copy .configs to git/dotfiles
cp ~/.config/i3/config ~/git/dotfiles/i3/config
cp ~/.config/i3status/config ~/git/dotfiles/i3status/config
cp ~/.config/dunst/dunstrc ~/git/dotfiles/dunst/dunstrc
cp ~/.config/fontconfig/fonts.conf ~/git/dotfiles/fontconfig/fonts.conf
cp ~/.zshrc ~/git/dotfiles/.zshrc
cp ~/.vimrc ~/git/dotfiles/.vimrc
cp ~/.Xresources ~/git/dotfiles/.Xresources
cp ~/.xinitrc ~/git/dotfiles/.xinitrc
