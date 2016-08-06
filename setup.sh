#!/bin/bash -x

DOT_FILE_REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# User specific overrides
source "$DOT_FILE_REPO/.zsh/user.conf"

# first param is string to print
# second is the unicode symbol (optional)
function print {
    local suffix=$2
    if [ -z ${suffix} ]; then suffix="bold";else suffix="setaf $suffix";fi
    color_out=`tput $suffix`
    reset=`tput sgr0`
    echo -e " $3 ${color_out}$1${reset}"
}

function safe_create {
  if [ ! -d "$1" ]; then
    print "$1 does not exist, creating it now.."
    echo "==> mkdir -p $1"
  fi
}

# install brews and casks
function brewer {
  while read line; do
    if [ ! -z "$line" ]
    then
      print "$HOMEBREW/bin/brew $line "
      `$HOMEBREW/bin/brew $line`
    fi
  done <"${1}"
}

function to_plist {
  local target=`basename "$1"`
  echo "plutil -convert xml1 -o /tmp/$target $1"
}

function to_binary {
  local target=`basename "$1"`
  `plutil -convert binary1 -o /tmp/$target "$1"`
  echo "/tmp/$target"
}

function setup_prefs {
    local temp=$(to_binary "$DOT_FILE_REPO/Preferences/$1")
    `cp -v "$temp" "$HOME/Library/Preferences" `
}

# download and install homebrew
mkdir -p $HOMEBREW && \
curl -L https://github.com/Homebrew/brew/tarball/master | \
tar xz --strip 1 -C $HOMEBREW


print "==> Brewing: installing formulas now...."
brewer "$DOT_FILE_REPO/brew/Brewfile"
brewer "$DOT_FILE_REPO/brew/Caskfile"

print "==> Linking: setting up all symlinks...."
## Setup all symlinks for configs ##
`ln -s "$DOT_FILE_REPO/.zsh"                                    ~`
`ln -s "$HOME/.zsh/.zshenv"                                     ~` #after above links
`ln -s "$DOT_FILE_REPO/.vim/.vimrc"                             ~`
`ln -s "$DOT_FILE_REPO/.vim"                                    ~`
`ln -s "$DOT_FILE_REPO/.gitconfig"                              ~`
`ln -s "$DOT_FILE_REPO/Preferences/.atom"                       ~`
`ln -s "$HOMEBREW/bin"                                          ~/bin`

print "==> Setting up binary prefernces...."
# Set up binary prefernces
setup_prefs "com.googlecode.iterm2.plist"
setup_prefs "com.apple.Terminal.plist"
`defaults read com.googlecode.iterm2` # Needed since on first startup after installation, it does not read the prefernces


# Install Vundle plugins
`$HOME/bin/vim +PluginInstall +qall`
#`vim +PluginInstall +qall`


# One time osx setup
#TODO source $DOT_FILE_REPO/.osx

# Unlinking for testing
#find . -type l -maxdepth 1 -exec unlink {} \;
