#!/bin/sh
# Steps to solving the Plex Nightmare
# 1. Rename files that need to be renamed
# 2. Move files as appropriate
PATH_TO_PLEX="X:\To Be Added"
PLEX_STAGING="X:\Staging"

# The main function from which this script runs
main () {

  if [ ! -d $PLEX_STAGING ]; then
    mkdir $PLEX_STAGING
  fi

  # List all files in a directory
  ALL_FILES="$(ls -LR "${PATH_TO_PLEX}")"
  echo "${ALL_FILES}"

  read -n1 -r -p "Press any key to continue" key
}

main
