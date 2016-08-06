source $ZPLUG_HOME/init.zsh

zplug "git/git", as:command, use:"contrib/completion/git-completion.zsh"
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

if ! zplug check; then
    zplug install
fi

# source plugins and add commands to the PATH
zplug load


# Set up all aliases
alias cls='clear'
alias u='cd ..'
alias src='source $ZDOTDIR/.zshrc'
alias ezsh='edit $ZDOTDIR/.zshrc'
alias l='ls -G -ltr'
alias la='ls -G -lat'
alias ws="cd $HOME/developer/workspace"
alias and="android"
alias ass="adb start-server"
alias aks="adb kill-server"
alias gf="git-flow"
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder'
alias vi='vim'
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder'
alias ql='qlmanage -p 2>/dev/null'

# GREP_COLOR=bright yellow on black bg.
# use GREP_COLOR=7 to highlight whitespace on black terminals
# LANG=C for speed. See also: http://www.pixelbeat.org/scripts/findrepo
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'
