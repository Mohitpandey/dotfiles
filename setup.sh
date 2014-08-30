#/bin/bash

export DOTFILES="$HOME/test/.dotfiles"
export HOMEBREW="$DOTFILES/homebrew"

xcode-select --install

mkdir -p $HOMEBREW && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C $HOMEBREW

git clone https://github.com/Mohitpandey/dotfiles.git $DOTFILES

export $PATH="$HOMEBREW/bin:$PATH"

#ln -s $DOTFILES/.oh-my-zsh.symlink $HOME/.oh-my-zsh
#ln -s $DOTFILES/.zshrc.symlink $HOME/.zshrc
#ln -s $DOTFILES/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
