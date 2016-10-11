#!/bin/sh
# Steps to solving the Plex Nightmare
# 1. Rename files that need to be renamed
# 2. Move files as appropriate
PATH_TO_PLEX="X:\To Be Added"

# List all files in a directory
ALL_FILES="$(ls -LR "${PATH_TO_PLEX}")"
echo "${ALL_FILES}"

read -n1 -r -p "Press any key to continue" key
