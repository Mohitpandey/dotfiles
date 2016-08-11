#!/usr/bin/env bash -u

function to_plist {
  local target=$(basename "$1")
  echo "plutil -convert xml1 -o /tmp/$target $1"
  $(plutil -convert xml1 -o /tmp/$target $1)
}

function to_binary {
  local target=$(basename "$1")
  $(plutil -convert binary1 -o "/tmp/$target" "$1")
  echo "/tmp/$target" # return statement
}
