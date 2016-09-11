export ZDOTDIR=$HOME/.zsh
source $ZDOTDIR/user.conf
export ZPLUG_CLONE_DEPTH=1
export ZPLUG_HOME=$HOMEBREW/opt/zplug
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
export ANDROID_BUILD_TOOLS="$ANDROID_HOME/build-tools/24.0.2"
export ANDROID_TOOLS=$ANDROID_HOME/tools
export HOMEBREW_CASK_OPTS=" --appdir=$CASK_APP_LINKS"
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# This gets added to $PATH after deduping above
path=(
  /usr/local/{bin,sbin}
  ~/bin
  $ANDROID_PLATFORM_TOOLS
  $ANDROID_TOOLS
  $ANDROID_BUILD_TOOLS
  $path
)

export EDITOR='atom'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( dir vcs)
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='174'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='174'
POWERLEVEL9K_DIR_HOME_BACKGROUND="006"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='006'

# some other vars to customize in future

# POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="white"
# POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="black"
# POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="red"
# POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="red"
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='005'
