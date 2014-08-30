#/bin/bash

export DOTFILES="$HOME/test/.dotfiles"
export HOMEBREW="$DOTFILES/homebrew"

xcode-select --install

git clone https://github.com/Mohitpandey/dotfiles.git $DOTFILES

mkdir -p $HOMEBREW && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C $HOMEBREW
mkdir -p ~/Applications

export PATH="$HOMEBREW/bin:$PATH"

# TODO: move the following to .zshenv
export HOMEBREW_CASK_OPTS="--caskroom=~/Applications --binarydir=$HOMEBREW/bin"

cd $DOTFILES

brew bundle brew/Brewfile
brew bundle brew/Caskfile

ln -s $DOTFILES/.oh-my-zsh.symlink $HOME/.oh-my-zsh
ln -s $DOTFILES/.zshrc.symlink $HOME/.zshrc
ln -s $DOTFILES/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s $DOTFILES/.vim.symlink $HOME/.vim
