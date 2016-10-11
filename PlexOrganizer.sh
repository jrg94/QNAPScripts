#!/bin/sh
# Steps to solving the Plex Nightmare
# 1. Rename files that need to be renamed
# 2. Move files as appropriate
PATH_TO_PLEX="X:\To Be Added"
PLEX_STAGING="X:\Staging"
PLEX_VIDEOS=$PLEX_STAGING"\Videos"
PLEX_MUSIC=$PLEX_STAGING"\Music"
PLEX_PICTURES=$PLEX_STAGING"\Pictures"

# Makes a director if it exists
make_dir () {
  if [ ! -d $1 ]; then
    mkdir $1
  fi
}

# Builds up the staging directory
build_staging () {
  # If the staging folder does not exist, create it
  make_dir $PLEX_STAGING

  # If the staging folder does not have a videos folder, make one
  make_dir $PLEX_VIDEOS

  # If the staging folder does not have a music folder, make one
  make_dir $PLEX_MUSIC

  # If the staging folder does not have a pictures folder, make one
  make_dir $PLEX_PICTURES
}

# The main function from which this script runs
main () {

  build_staging

  # List all files in a directory
  ALL_FILES="$(ls -LR "${PATH_TO_PLEX}")"
  echo "${ALL_FILES}"

  read -n1 -r -p "Press any key to continue" key
}

main
