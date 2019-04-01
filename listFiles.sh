#!/bin/bash

##############################################################################################
#Author: Eric Claus
#Date: 2/6/17
#Unix Admin Lab - Scripting 2
#Part 3
#Purpose: List all files in a given directory. Desired directory is specified as a parameter.
#	Backup files to new directory if file is newer than the backed-up file copy.
##############################################################################################

###################################
# Get rid of bash error messages. #
###################################
#exec 2>/dev/null

#############
# Help file #
#############
function display_help {
	echo
	echo " -- Script to list contents of a directory and incrementally"
	echo "    backup files to new directory."
	echo " -- Usage: $0 <source_directory> <dest_directory>"
	echo
	echo "	-h		Display the help file."
	echo
	exit
}

###########################################
# getops (parsing command line arguments) #
# Note: getops was used instead of getop  #
# 	for the sake of simplicity        #
###########################################
while getopts 'h' option; do
	case "option" in
		h) display_help
		;;
		*) display_help
		;;
	esac
done

if [ $# != 2 ]; then
	echo
	echo "Error: please enter two directory names."
	display_help
fi

##############################################################################################

#Initiate file count variable
filecount=0

#Declaration of main function
function Main {

mkdir $2

for name in $1/*; do
	printf "$name --- "

	if [ -d "$name" ]; then
		printf "Directory --- "
	else
		printf "File --- "
	fi

	((filecount++))

	filename="${name##*/}"

	if [ "$name" -nt "$2/$filename" ]; then
		cp -u -r "$name" "$2/$filename"
		printf "Backed-up\n"
	else

		printf "Not backed-up\n"
	fi

done

echo
echo "Total number of files is $filecount"
echo

}

#Call Main function
Main $1 $2
