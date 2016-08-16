#!/usr/bin/env zsh

DOT_FILE_REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install brews and casks
function brewer {
	while read line; do
		if [ ! -z "$line" ]; then
			${HOMEBREW}/bin/brew $line >/dev/null 2>&1
		fi
	done <"${1}"
}

function setup_prefs {
	local temp
	temp=$(to_binary "$DOT_FILE_REPO/Preferences/$1")
	mv -v -f  "$temp" "$HOME/Library/Preferences"
}

function install_brew {
	which -s brew
	if [[ $? -eq 1  ]]; then
		mkdir -p "$HOMEBREW" && \
			curl -L "https://github.com/Homebrew/brew/tarball/master" | \
			tar xz --strip 1 -C "$HOMEBREW"
	else
		e_warning "Brew already installed, running update!"
		brew update
	fi
}

function brew_formulas {
	e_note "Brewing formulas now..."
	brewer "$DOT_FILE_REPO/brew/Brewfile"
	brewer "$DOT_FILE_REPO/brew/Caskfile"
}

function setup_dot_dir {
	ln -s "$DOT_FILE_REPO/.zsh" ~
	source "$HOME/.zsh/user.conf"
	source "$HOME/.zsh/.zshenv"
	source "$HOME/.zsh/functions.zsh"
}

function setup_symlinks {
	e_note "Setting up all symlinks now..."
	ln -s "$HOME/.zsh/.zshenv"                                     ~
	ln -s "$DOT_FILE_REPO/.vim/.vimrc"                             ~
	ln -s "$DOT_FILE_REPO/.vim"                                    ~
	ln -s "$DOT_FILE_REPO/.gitconfig"                              ~
	ln -s "$DOT_FILE_REPO/Preferences/.atom"                       ~
	ln -s "$HOMEBREW/bin"                                          ~/bin
	ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs"     ~/iCloud
}

e_header      "System setup initiated!"
setup_dot_dir
e_note        "Trying to install Hombrew.."
install_brew
brew_formulas
setup_symlinks

e_note "Setting up binary prefernces...."
setup_prefs "com.googlecode.iterm2.plist"
setup_prefs "com.apple.Terminal.plist"
# Needed because on first startup after installation, it does not read the prefs
# $(defaults read com.googlecode.iterm2 >/dev/null 2>&1)

# One time osx setup
if [[ "$(uname)" == "Darwin" ]]; then
	source "$DOT_FILE_REPO/macos.defaults"
fi

# Install Vundle plugins : Do this last
"$HOME/bin/vim" +PluginInstall +qall >/dev/null 2>&1

e_success "Setup complete. Quit this terminal and start a new one."
osascript -e "tell app \"Terminal\" to quit"
