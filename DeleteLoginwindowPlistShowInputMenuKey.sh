#!/bin/sh
####################################################################################################
#
# More information: 
#
# GitRepo: 
#
# License: http://macmule.com/license/
#
####################################################################################################

###
# Returns a list of all folders found under /Users
###
for userFolders in `ls -d -1 /Users/* | cut -c 8- | sed -e 's/ /\\ /g' | grep -v "Shared"`

do
	# Check for the showInputMenu key in /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist...
	if ! ( sudo defaults read /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow showInputMenu &> /dev/null ); then
	
		# If  showInputMenu key in /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist does not exist then...
		echo "showInputMenu key not set in /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist..."
		
		echo ""
		
	else
	
	# If showInputMenu key in /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist exists...
	
	# Delete the showInputMenu key from the loginwindow plist
	sudo defaults delete /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow showInputMenu
	echo "Deleted showInputMenu key from /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist..."
	
	# Make the users whose homefolder the plist is located the owner of the file
	sudo chown "$userFolders" /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist
	echo "Made "$userFolders" owner of the file /Users/"$userFolders"/Library/Preferences/com.apple.loginwindow.plist..."
	
	echo ""
	fi
	
done
