#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
	
	# @staticmethod
	# def run(cmd):
	# 	process = subprocess.Popen(cmd,stdout=subprocess.PIPE, stderr=subprocess.PIPE,shell=True)
	# 	out, err = process.communicate()
	# 	if not err:
	# 		printout(out,BLUE)
	# 	else:
	# 		printout(err,RED)
	# 		exit()

	@staticmethod
	def run(cmd):
		printout("Running: "+cmd,MAGENTA)
		try:
			out = subprocess.check_output(cmd,shell=True,stderr=subprocess.STDOUT)
			printout(out,BLUE)
		except subprocess.CalledProcessError as e:	
			printout(e.output,RED)
			sys.exit()



# TODO: Make sure all directories exist

HOME = os.environ['HOME'] + "/TEST"
DOTFILES = HOME + "/dotfiles"
HOMEBREW = HOME + "/homebrew"
CASK_APPS = HOME + "/cask/Applications"
Util.mkdir(CASK_APPS)

print "Setting up your MAC now...."

clone_repo = "git clone --progress https://github.com/Mohitpandey/dotfiles.git {DOTFILES}".format(**locals())
Util.run(clone_repo)

printout("Current working dir: "+os.getcwd(),GREEN)
printout("Changin to dotfiles dir",YELLOW)
os.chdir(DOTFILES)
printout("Current working dir: "+os.getcwd(),GREEN)

os.environ["HOMEBREW_CASK_OPTS"] = "--caskroom={CASK_APPS} --binarydir={HOMEBREW}/bin".format(**locals())

install_homebrew = "mkdir -p {HOMEBREW} && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C {HOMEBREW}".format(**locals())
Util.run(install_homebrew)

os.environ['PATH'] = HOMEBREW + "/bin" + ":" + os.environ['PATH']


brew_bundler = "brew bundle {DOTFILES}/brew/Brewfile".format(**locals())
Util.run(brew_bundler)

cask_bundler = "brew bundle {DOTFILES}/brew/Caskfile".format(**locals())
Util.run(cask_bundler)   



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
