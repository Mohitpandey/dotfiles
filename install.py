#!/usr/bin/env python

import sys
import os
import subprocess

BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)

#following from Python cookbook, #475186
def has_colours(stream):
    if not hasattr(stream, "isatty"):
        return False
    if not stream.isatty():
        return False # auto color only on TTYs
    try:
        import curses
        curses.setupterm()
        return curses.tigetnum("colors") > 2
    except:
        # guess false in case of error
        return False
has_colours = has_colours(sys.stdout)


def printout(text, colour=WHITE):
        if has_colours:
                seq = "\x1b[1;%dm" % (30+colour) + text + "\x1b[0m" + "\n"
                sys.stdout.write(seq)
        else:
                sys.stdout.write(text)

class Util:
	@staticmethod
	def mkdir(path):
		if not os.path.exists(path):
			os.makedirs(path)
    		printout("Created: " + path, YELLOW) 

# TODO: Make sure all directories exist

HOME = os.environ['HOME'] + "/TEST"
DOTFILES = HOME + "/dotfiles"
HOMEBREW = DOTFILES + "/homebrew"

# Util.mkdir(DOT)

printout("Initiating your MAC setup...", CYAN)
printout("Cloing your dotfile REPO", CYAN)

clone_repo = ["git", "clone", "--progress", "https://github.com/Mohitpandey/dotfiles.git",DOTFILES]
print subprocess.call(clone_repo)

printout("HOME : " + HOME,GREEN)
printout("DOTFILES : " + DOTFILES,GREEN)



printout("Current working dir: "+os.getcwd(),GREEN)
printout("Changin to dotfiles dir",YELLOW)
os.chdir(DOTFILES)
printout("Current working dir: "+os.getcwd(),GREEN)

install_homebrew = "mkdir -p {homebrew} && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C {homebrew}".format(homebrew=HOMEBREW)
process = subprocess.Popen(install_homebrew,stdout=subprocess.PIPE, stderr=subprocess.STDOUT,shell=True)
install_homebrew_output, err = process.communicate()

printout(install_homebrew_output,BLUE)
   

# export DOTFILES="$HOME/test/.dotfiles"
# export HOMEBREW="$DOTFILES/homebrew"

# xcode-select --install

# git clone https://github.com/Mohitpandey/dotfiles.git $DOTFILES

# mkdir -p $HOMEBREW && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C $HOMEBREW
# mkdir -p ~/Applications

# export PATH="$HOMEBREW/bin:$PATH"

# # TODO: move the following to .zshenv
# export HOMEBREW_CASK_OPTS="--caskroom=~/Applications --binarydir=$HOMEBREW/bin"

# cd $DOTFILES

# brew bundle brew/Brewfile
# brew bundle brew/Caskfile

# ln -s $DOTFILES/.oh-my-zsh.symlink $HOME/.oh-my-zsh
# ln -s $DOTFILES/.zshrc.symlink $HOME/.zshrc
# ln -s $DOTFILES/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
# ln -s $DOTFILES/.vim.symlink $HOME/.vim
