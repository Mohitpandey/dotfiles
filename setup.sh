#/bin/bash

source config.sh

ln -s $DOTFILES/.oh-my-zsh.symlink $HOME/.oh-my-zsh
ln -s $DOTFILES/.zshrc.symlink $HOME/.zshrc

ln -s $DOTFILES/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
