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
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export STUDIO_JDK="/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk"

# This dedupes
typeset -gU cdpath fpath path

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
