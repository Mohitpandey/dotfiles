#!/usr/bin/env zsh


# curl https://raw.githubusercontent.com/Mohitpandey/dotfiles/update_and_modernize/setup.zsh -o setup.zsh &&  source setup.zsh

# zsh -c "$(curl -s https://raw.githubusercontent.com/Mohitpandey/dotfiles/update_and_modernize/setup.zsh)"
REPO_URL="https://github.com/Mohitpandey/dotfiles"
CLONE_DIR="dotfiles"

git clone --recursive -b update_and_modernize --depth 1 $REPO_URL $CLONE_DIR

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$CLONE_DIR"

function setup_prefs {
	local temp
	temp=$(to_binary "$DIR/Preferences/$1")
	mv -v -f  "$temp" "$HOME/Library/Preferences"
}

function install_brew {
	which -s brew
	if [[ $? -eq 1  ]]; then
		mkdir -p "$HOMEBREW" && \
		git clone --depth 1 https://github.com/Homebrew/brew "$HOMEBREW"
	else
		e_warning "Brew already installed, skipping!"
		brew update
	fi
	if [[ ! -e "$HOMEBREW/bin/brew" ]]; then
		e_error "$HOMEBREW/bin/brew not found! Exiting!"
		exit
	fi
}

function brew_formulas {
	source "$DIR/brew/Brewfile"
}

function atom_package_installer {
		cmd_file_param "apm install"  "Preferences/.atom/packages.cson"
}

function setup_dot_dir {
	ln -s "$DIR/.zsh" ~
	source "$HOME/.zsh/user.conf"
	source "$HOME/.zsh/.zshenv"
	source "$HOME/.zsh/functions.zsh"
}

function setup_symlinks {
	e_note "Setting up all symlinks now..."
	ln -s "$HOME/.zsh/.zshenv"                                     ~
	ln -s "$DIR/.vim/.vimrc"                                       ~
	ln -s "$DIR/.vim"                                              ~
	ln -s "$HOME/.vim"                                             ~/.config/nvim
	ln -s "$HOME/.vimrc"                                           ~/.config/nvim/init.vim
	ln -s "$DIR/.gitconfig"                                        ~
	ln -s "$DIR/Preferences/.atom"                                 ~
	ln -s "$HOMEBREW/bin"                                          ~/bin
	ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs"     ~/iCloud
}

setup_dot_dir
e_header         "System setup initiated!"
e_note           "Trying to install Hombrew.."
install_brew
e_note           "Brewing formulas now..."
brew_formulas
mkdir -p ~/.config/nvim
setup_symlinks

e_note           "Setting up binary prefernces...."
setup_prefs      "com.googlecode.iterm2.plist"
setup_prefs      "com.apple.Terminal.plist"

e_note 	         "Installing atom packages"
atom_package_installer

# One time osx setup
if [[ "$(uname)" == "Darwin" ]]; then
	source "$DIR/macos.defaults"
fi

# Install Vundle plugins : Do this last
`${HOME}/bin/nvim +PluginInstall +qall`

e_header "Setup complete!"
osascript -e "tell app \"Terminal\" to quit"
