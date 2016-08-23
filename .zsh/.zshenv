export ZDOTDIR=$HOME/.zsh
source $ZDOTDIR/user.conf
export ZPLUG_CLONE_DEPTH=1
export ZPLUG_HOME=$HOMEBREW/opt/zplug
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export ANDROID_HOME="$DEV/android/sdk"
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
export ANDROID_BUILD_TOOLS="$ANDROID_HOME/build-tools/21.0.1"
export ANDROID_TOOLS=$ANDROID_HOME/tools
export JAVA_HOME=`/usr/libexec/java_home 2>/dev/null` # could also pass -v 1.8`
export HOMEBREW_CASK_OPTS=" --appdir=$CASK_APP_LINKS"

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
POWERLEVEL9K_MODE='awesome-patched'
