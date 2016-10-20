#!/bin/sh
# Steps to solving the Plex Nightmare
# 1. Rename files that need to be renamed
# 2. Move files as appropriate

# Makes a director if it exists
make_dir () {
	if [ ! -d $1 ]; then
		mkdir $1
	fi
}

# Builds up the plex directory
build_plex () {
	make_dir $1
	make_dir $2
	make_dir $3
	make_dir $4
	make_dir $5
}

# The main function from which this script runs
main () {

	# Test if the user supplied arguments
	if [ -z $1 ]; then
		echo "No arguments applied"
		exit
	fi
	
	# Test if plex directory exist
	if [ ! -d $1 ]; then
		echo "Failed to find "$1""
		exit
	fi

	# Test if the supplied directory is an absolut path
	#if [[ ! "$1" = /* ]] || [[ ! "$1" = "C:\*" ]]; then
	#  echo "Failed to give an absolute path"
	#  exit
	#fi
	
	# Define paths based on user input
	PATH_TO_PLEX=$1
	PLEX_UPLOAD=$1"/Upload"
	PLEX_STAGING=$1"/Staging"
	PLEX_VIDEOS=$PLEX_STAGING"/Videos"
	PLEX_MUSIC=$PLEX_STAGING"/Music"
	PLEX_PICTURES=$PLEX_STAGING"/Pictures"

	# Build staging directory
	build_plex $PLEX_UPLOAD $PLEX_STAGING $PLEX_VIDEOS $PLEX_PICTURES $PLEX_MUSIC

	# Get size of directory
	SIZE_OF_UPLOAD=$(du -s "${PLEX_UPLOAD}" | awk '{print $1}')

	# Load in LastDumpSize
	. ./StateData.txt

	# If the upload directory is empty, update and exit
	if [ $SIZE_OF_UPLOAD = 0 ]; then
		echo "${PLEX_UPLOAD} is empty"
		sed -i 's/LastDumpSize=.*/LastDumpSize=0/' ./StateData.txt
		exit
	fi

	# If the upload directory has not changed size, exit
	if [ $SIZE_OF_UPLOAD != $LastDumpSize ]; then
		echo "${PLEX_UPLOAD} size is changing"
		sed -i 's/LastDumpSize=.*/LastDumpSize='"$SIZE_OF_UPLOAD"'/' ./StateData.txt
		exit
	fi

	echo "Moving files from upload to staging"

	# Otherwise, lets do this!
	# Get the list of everything with absolute paths!
	LIST_OF_UPLOAD=$(du -a ${PLEX_UPLOAD} | awk '{$1="";print}' | sed -e 's/^[[:space:]]*//')

	# From the upload list, grab each category
	PICTURES=$(grep -e '.PNG' -e '.png' -e '.GIF' -e '.gif' <<< "$LIST_OF_UPLOAD")
	MUSIC=$(grep -e '.mp3' <<< "$LIST_OF_UPLOAD")
	VIDEOS=$(grep -e '.mp4' <<< "$LIST_OF_UPLOAD")

	# SORT! :D
	[[ ! -z "$PICTURES" ]] && mv ${PICTURES} $PLEX_PICTURES
	[[ ! -z "$MUSIC" ]] && mv ${MUSIC} $PLEX_MUSIC
	[[ ! -z "$VIDEOS" ]] && mv ${VIDEOS} $PLEX_VIDEOS
}

main $1
