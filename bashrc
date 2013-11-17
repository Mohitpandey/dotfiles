# .bashrc

shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

# [[ -s "$HOME/.commonrc" ]] && source "$HOME/.commonrc"

# source file
source ~/.exports
source ~/.completions
source ~/.aliases
source ~/.prompt

if [ -f `$HOMEBREW/bin/brew --prefix`/etc/bash_completion ]; then
    . `$HOMEBREW/bin/brew --prefix`/etc/bash_completion
    . `$HOMEBREW/bin/brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

source $DEVELOPMENT/Tools/homebrew/etc/bash_completion.d/git-flow-completion.bash
