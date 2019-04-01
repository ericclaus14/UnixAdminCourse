#!/bin/bash

##############################################################################################
#Author: Eric Claus
#Date: 1/30/17
#Unix Admin Lab - Scripting 1
#Part 3
#Purpose: Prompt user to enter a number between a range they specify. Display error message 
# with valid range. Exit script when a valid int is entered. Verify parameters are valid. 
# Print syntax/help message is user requests help (--help) or if they leave off parameters.
##############################################################################################

###################################
# Get rid of bash error messages. #
###################################
exec 2>/dev/null

#############
# Help file #
#############
function display_help {
	echo
	echo " -- Syntax: $(basename "$0")[-h] <lower boundary> <upper boundary>"
	echo
	echo " -- Program to check if a number is within a range."
	echo
	echo "	-h		Display the help file."
	echo
	echo "	<lower boundary> and <upper boundary> specify the range."
	echo
	echo " -- Usage: Run the script and pass in the boundaries of the number range."
	echo " 	     The program will then prompt for a number to check. The program"
	echo " 	     will check to see if the number is within the range. If it is"
	echo "	     not, it will reprompt until a valid number is entered."
	echo "	     The numbers must be positive integers."
	echo
	echo " -- Example: $0 50 100"
	echo
	exit
}

###########################################
# getops (parsing command line arguments) #
# Note: getops was used instead of getop  #
# 	for the sake of simplicity        #
###########################################
if [ $# -eq 0 ]; then 
	display_help; 
fi

while getopts 'h' option; do
	case "option" in
		h) display_help
		;;
		*) display_help
		;;
	esac
done

#Declare main function
function Main {

	#Initialize variable to determine if the entered integer is valid
	numvalid=false

	#Formatting and initial user prompt
	printf "\n"
	printf "Enter an integer between $1 and $2: " #Use parameters from script call.

	# Loop until the user enters a valid number.
	while [ $numvalid = false ]; do
		read num
		#Check if user's entered number is in the valid range. 
		if [ $num -gt $1 -a $num -lt $2 ]; then
			printf "Congratulations, this number is valid.\n"
			numvalid=true;
		else
			printf "Try again. Enter an integer between $1 and $2: "
		fi
	done
	printf "\n"
}

#Check if there are two entered parameters, both of which are positive integers, 
# and if the lower number is entered first.
#If parameters are valid, call Main function. If not, exit.
if [ $1 -ge 0 -a $2 -ge $1 -a $# -eq 2 ]; then 
	Main $1 $2
else
	printf "\n"
	printf "Error: Invalid parameters. The numbers must be two positive integers with" 
	printf " the lower value entered first. -h to display help file."
	printf "\n \n"
fi
