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
alias ezsh='atom $ZDOTDIR/.zshrc'
alias l='ls -G -ltr'
alias la='ls -G -lat'
alias ws="cd $DEV/workspace"
alias and="android"
alias ass="adb start-server"
alias aks="adb kill-server"
alias gf="git-flow"
alias showHidden='defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder'
alias vi='nvim'
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder'
alias ql='qlmanage -p 2>/dev/null'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'

# source in your functions
source $ZDOTDIR/functions.zsh
export JAVA_HOME=`/usr/libexec/java_home 2>/dev/null` # could also pass -v 1.8`
