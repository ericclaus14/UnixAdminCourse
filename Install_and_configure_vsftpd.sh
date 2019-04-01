#!/bin/bash

##############################################################################################
#Author: Eric Claus
#Date: 2/5/17
#Unix Admin Lab - Scripting 1
#Part 4
#Purpose: Install VSFTPD and configure it to enable write and ssl. If VSFTPD is installed,
#	first remove it then reinstall. 
#Script must be run as root.
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
	echo " -- Script to install VSFTPD, enable writing, and enable SSL."
	echo " -- If VSFTPD is already installed, it will be uninstalled/reinstalled"
	echo
	echo " -- Script must be run as root."
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

##############################################################################################

#Declaration of main function
function Main {

	#Check if VSFTPD is installed and remove it if so.
	if hash vsftpd; then
		apt-get purge vsftpd
	fi
	
	#Install vsftpd
	apt-get update
	apt-get -y install vsftpd

	#Backup vsftpd.conf
	cp /etc/vsftpd.conf /etc/vsftpd.original

	#Uncomment #write_enable and send to temp file
	sed -i '/write_enable/s/^#//g' /etc/vsftpd.conf

	#Append ssl_enable=YES to temp file
	echo "#Comment to disable SSL." >> /etc/vsftpd.conf
	echo "ssl_enable=YES" >> /etc/vsftpd.conf

	#Copy temp file over config file
	#cp /etc/vsftpd.temp /etc/vsftpd.conf

	#Restart vsftpd
	service vsftpd restart

}

#Call Main function
Main
