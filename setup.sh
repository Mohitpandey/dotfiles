#!/usr/bin/env bash

# set -x

DOT_FILE_REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Link env files
$(ln -s "$DOT_FILE_REPO/.zsh"                                    ~ )
$(ln -s "$HOME/.zsh/.zshenv"                                     ~ )

# User specific overrides
source "$DOT_FILE_REPO/.zsh/user.conf"
source "$DOT_FILE_REPO/.zsh/.zshenv"
source "$DOT_FILE_REPO/.zsh/functions.sh"

# first param is string to print
# second is the unicode symbol (optional)
function print {
    local suffix=$2
    if [ -z ${suffix} ]; then suffix="bold";else suffix="setaf $suffix";fi
    color_out=$(tput $suffix)
    reset=$(tput sgr0)
    echo -e "${color_out}$1${reset}"
}

# install brews and casks
function brewer {
  while read line; do
    if [ ! -z "$line" ]
    then
      print "$HOMEBREW/bin/brew $line >/dev/null 2>&1"
      $($HOMEBREW/bin/brew $line >/dev/null 2>&1)
    fi
  done <"${1}"
}

function setup_prefs {
    local temp=$(to_binary "$DOT_FILE_REPO/Preferences/$1")
    $(mv -v -f  "$temp" "$HOME/Library/Preferences")
}

# download and install homebrew
$(mkdir -p $HOMEBREW && \
curl -L https://github.com/Homebrew/brew/tarball/master | \
tar xz --strip 1 -C $HOMEBREW)


print "==+> Brewing formulas now...."
brewer "$DOT_FILE_REPO/brew/Brewfile"
brewer "$DOT_FILE_REPO/brew/Caskfile"

print "==+> Linking: setting up all symlinks...."
$(ln -s "$DOT_FILE_REPO/.vim/.vimrc"                             ~ )
$(ln -s "$DOT_FILE_REPO/.vim"                                    ~ )
$(ln -s "$DOT_FILE_REPO/.gitconfig"                              ~ )
$(ln -s "$DOT_FILE_REPO/Preferences/.atom"                       ~ )
$(ln -s "$HOMEBREW/bin"                                          ~/bin )
$(ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs"     ~/iCloud )


print "==+> Setting up binary prefernces...."
setup_prefs "com.googlecode.iterm2.plist"
setup_prefs "com.apple.Terminal.plist"
# Needed because on first startup after installation, it does not read the prefs
$(defaults read com.googlecode.iterm2 >/dev/null 2>&1)

# One time osx setup
source "$DOT_FILE_REPO/macos.defaults"

# Install Vundle plugins : Do this last
$($HOME/bin/vim +PluginInstall +qall >/dev/null 2>&1)

# Unlinking for testing
#find . -type l -maxdepth 1 -exec unlink {} \;
