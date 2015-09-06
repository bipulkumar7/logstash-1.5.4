#!/bin/bash
# Script: Install_Logstash.sh
# Author: Bipul kumar, Bangalore, INDIA
# Date: 2015-09-05
# Version: 0.1

#defining TEMP
TEMP="`mktemp`"
#Defining echo function
#defining white color for Success.
	function ee_info()
	{
			echo $(tput setaf 7)$@$(tput sgr0)
	}

	#defining blue color for Running.
		function ee_echo()
		{
				echo $(tput setaf 4)$@$(tput sgr0)
		}
		#Defining red color for Error
			function ee_fail()
			{
					echo $(tput setaf 1)$@$(tput sgr0)
			}
clear

#Checking User Authentication
	if [[ $EUID -eq 0 ]]; then
		ee_info "Thank you for giving me a SUDO user privilege"
	else
		ee_fail "I need a SUDO privilage !! :( "
		ee_fail "Use: sudo bash RTcamAssign2.sh"
	exit 1
	fi

	ee_info "OH!! You have passed the Authentication part."
#UPDATING UBUNTU
	# ee_echo "Let me Update your System. Please wait..."
	# apt-get update &>> /dev/null
	# ee_info "Finally this system is ready to install Logstash with it's dependencies"

#CHECKING JAVA VERSION AND IT PACKAGE IS INSTALLED OR NOT

	  version=$(java -version 2>&1 | sed 's/version "\(.*\)\(.*\)\"/\1\2/; 1q')

	 if [$? -ne 0]; then
		ee_echo "Oh noo!! you don't have JAVA/OpenJDK package Installed. Let me install it for you, please wait.."
	apt-get -y install default-jre &>> /dev/null
	apt-get -y install default-jdk &>> /dev/null
	else
		ee_info "OH!! you already have $version installed"	
	fi

#DOWNLOADING LATEST VERSION FROM LOGSTASH THEN UNZIP IT LOCALLY .
	ee_echo " I am going to download Logstash from http://download.elastic.co/logstash/logstash-1.5.4.tar.gz please wait.."
	cd ~ &&  wget https://download.elastic.co/logstash/logstash/logstash-1.5.4.tar.gz #>> $TEMP 2>&1
        if [ $? -eq 0 ]; then
 	ee_info "Done!! latest Logstash has been downloaded Successfully"
	  else
		ee_fail "ERROR:Failed to get latest tar file, Please check log files $TEMP" 1>&2
	fi
	#EXTRACTING THE LATEST TAR FILES
	ee_echo "Let me extract the tar file"
	cd ~ && tar zxvf logstash-1.5.4.tar.gz &>> /dev/null
       if [ $? -eq 0 ]; then
	ee_info "Logstash file has been and extracted Successfully"
	rm -rf logstash-1.5.4.tar.gz
	cd logstash-1.5.4
	else
	ee_fail "ERROR:Failed to extract the .tar.gz file"
	fi
	ee_echo "Thank's And keep coming on https://bipul.net"







