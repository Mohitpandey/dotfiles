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

	# We want to show progress to the user. If
	# we run brew cmd from python, the output
	# will take time to show up since there might
	# be lot of formulas. While trying to stream,
	# I ran into problem with differentiating error
	# and normal output. Since I wasn to show errors in
	# error and capture attention, I took this route.
	# If there is a better way, please let me know.
	@staticmethod
	def brewer(formula):		
		if formula and not formula.startswith('#'):
			Util.run("brew {formula}".format(**locals()))		
		
		
	@staticmethod
	def install_formulas(formulas):
		for formula in formulas:
			Util.brewer(formula)

	@staticmethod
	def handle_brewfiles(brew_file_location):
		brew_files = os.listdir(brew_file_location)
		for file in brew_files:
			Util.install_formulas(Util.get_file_lines(brew_file_location+"/"+file))

	@staticmethod
	def get_file_lines(file):
		return [line.strip() for line in open(file)]

	@staticmethod
	def run(cmd):
		printout("Running: "+cmd,MAGENTA)
		try:
			out = subprocess.check_output(cmd,shell=True,stderr=subprocess.STDOUT)
			print out
		except subprocess.CalledProcessError as e:	
			printout(e.output,RED)
			sys.exit()

	@staticmethod
	def symlink(dir,target):
		files = os.listdir(dir)
		if(len(files)):
			printout("Symlinking:",MAGENTA)
		for file in files:
			if file.endswith(".symlink"):
				source_file = "{dir}/{file}".format(**locals())
				target_file = target + "/" + file.replace(".symlink","")				
				print "\t{source_file} → {target_file}".format(**locals())				
				os.symlink(source_file,target_file)


	@staticmethod
	def sourcer(file):
		Util.run("source {file}".format(**locals()))


# Just this makes it annoying having install script written in pythong
# Though there are easy workarounds.
HOME     = os.environ['HOME']
DEV      = "developer"
DOTFILES = "{HOME}/{DEV}/dotfiles".format(**locals()) # created by clone    
HOMEBREW = "{HOME}/{DEV}/homebrew".format(**locals()) # created by brew
CASKS    = "{HOME}/{DEV}/casks".format(**locals())
Util.mkdir(CASKS)

print "Setting up your MAC now...."

clone_repo = "git clone --recursive https://github.com/Mohitpandey/dotfiles.git {DOTFILES}".format(**locals())
Util.run(clone_repo)

os.environ["HOMEBREW_CASK_OPTS"] = "--caskroom={CASKS} --binarydir={HOMEBREW}/bin".format(**locals())

install_homebrew = """mkdir -p {HOMEBREW} && curl -L https://github.com/Homebrew/homebrew/tarball/master \
 				   | tar xz --strip 1 -C {HOMEBREW}""".format(**locals())
Util.run(install_homebrew)
os.symlink(HOMEBREW+"/bin",HOME+"/bin")

os.environ['PATH'] = HOMEBREW + "/bin" + ":" + os.environ['PATH']

# Install Brew formulas 
Util.handle_brewfiles(DOTFILES + "/brew")

Util.symlink(DOTFILES,HOME)

Util.symlink(DOTFILES+"/Preferences",HOME+"/Library/Preferences")

# Setup all OSX defaults
Util.sourcer(DOTFILES + "/.osx")

SUBLIME_SUPP = "{HOME}/Library/Application Support/Sublime Text 3".format(**locals())
# TODO: clean up

Util.mkdir(SUBLIME_SUPP+"/Installed Packages")
Util.mkdir(SUBLIME_SUPP+"/Packages/User")
os.symlink(DOTFILES+"/sublime_init/Package Control.sublime-package",SUBLIME_SUPP+"/Installed Packages/Package Control.sublime-package")
os.symlink(DOTFILES+"/sublime_init/Package Control.sublime-settings",SUBLIME_SUPP+"/Packages/User/Package Control.sublime-settings")
os.symlink(DOTFILES+"/sublime_init/Preferences.sublime-settings",SUBLIME_SUPP+"/Packages/User/Preferences.sublime-settings")
os.symlink(DOTFILES+"/sublime_init/Tomorrow-Night-Eighties.tmTheme",SUBLIME_SUPP+"/Packages/User/Tomorrow-Night-Eighties.tmTheme")
# 
Util.run(HOME+"/bin/vim +PluginInstall +qall")
Util.run(HOME+"/.vim/bundle/YouCompleteMe/install.sh")
# xcode-select --install

# # TODO: move the following to .zshenv
# export HOMEBREW_CASK_OPTS="--caskroom=~/Applications --binarydir=$HOMEBREW/bin"
