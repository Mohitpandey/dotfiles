#!/usr/bin/env zsh

# set -x

function to_plist {
  local target=$(basename "$1")
  echo "plutil -convert xml1 -o /tmp/$target $1"
  $(plutil -convert xml1 -o /tmp/$target "$1")
}

function to_binary {
  local target=$(basename "$1")
  $(plutil -convert binary1 -o "/tmp/$target" "$1")
  echo "/tmp/$target" # return statement
}

# first param is string to print
# second is the unicode symbol (optional)
function print {
    local suffix=$2
    if [ -z ${suffix} ]; then suffix="bold";else suffix="setaf $suffix";fi
    color_out=$(tput $suffix)
    reset=$(tput sgr0)
    echo -e "${color_out}$1${reset}"
}

function unl {
  $(cd)
  $(find . -type l -maxdepth 1 -exec unlink {} \;)
}
# courtesy natelandau
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

function e_header() {
  printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}

function e_arrow() {
  printf "➜ $@\n"
}

function e_success() {
  printf "${green}✔ %s${reset}\n" "$@"
}

function e_error() {
  printf "${red}✖ %s${reset}\n" "$@"
}

function e_warning() {
  printf "${tan}➜ %s${reset}\n" "$@"
}

function e_underline() {
  printf "${underline}${bold}%s${reset}\n" "$@"
}

function e_bold() {
  printf "${bold}%s${reset}\n" "$@"
}

function e_note() {
  printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}
