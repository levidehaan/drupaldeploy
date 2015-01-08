#!/bin/bash

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'FreeBSD' ]]; then
    which -s brew
	if [[ $? != 0 ]] ; then
		ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	else
		brew update
	fi

	for pkg in dialog; do
    	if brew list -1 | grep -q "^${pkg}\$"; then
        	echo "Package '$pkg' is installed"
    	else
        	echo "Package '$pkg' is not installed"
    	fi
	done
elif [[ "$unamestr" == 'Linux' ]]; then
   echo "Good Job Running Linux "
fi



INPUT=/tmp/menu.sh.$$

OUTPUT=output.log
 
vi_editor=${EDITOR-vi}
 
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM


function start_vm() {
    dialog --backtitle "Starting VM!"\
	 --title "Starting......" --clear \
	 --infobox "please wait while vm starts. :)" 40 90
      
    vagrant up
    
    dialog --backtitle "VM Starting"\
	 --title "VM Starting"\
	 --msgbox "$(cat output.log)" 40 90
}

function stop_vm() {
    dialog --backtitle "Stopping VM!"\
	 --title "Stopping......" --clear \
	 --infobox "please wait while vm stops. :)" 40 90
      
    vagrant halt
    
    dialog --backtitle "VM Stopping"\
	 --title "VM Stopping"\
	 --msgbox "$(cat output.log)" 40 90
}

function restart_vm() {
    dialog --backtitle "Reloading VM!"\
	 --title "Reloading......" --clear \
	 --infobox "please wait while vm reloads. :)" 40 90
      
    vagrant reload
    
    dialog --backtitle "VM Reloading"\
	 --title "VM Reloading"\
	 --msgbox "$(cat output.log)" 40 90
}

function install_vagrant_plugins() {
	dialog --backtitle "Installing Vagrant Plugins Please be patient!"\
	 --title "Installing......" --clear \
	 --infobox "please wait while the plugins are installed the job will start once you\
	  close this window. :)" 40 90
	
	vagrant plugin install vagrant-vbguest 2>&1 | tee output.log

	dialog --backtitle "Installing Vagrant Plugins"\
	 --title "Finished Installation!"\
	 --msgbox "$(cat output.log)" 40 90
	
}

function install_intellij() {
	dialog --backtitle "Installing VM With Intellij Please be patient!"\
	 --title "Installing......" --clear\
	 --infobox "please wait while the vm is built and installed the job will start once you\
	  close this window.\n there is a log that you can view when it is finished. \n \
	  this can take a long time. be patient. :)" 40 90

	export FACTER_options='intellij';
	vagrant up 2>&1 | tee output.log
	vagrant reload

	dialog --backtitle "Installing VM With Intellij COMPLETED!!"\
	 --title "Finished Installation!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function install_Kubernetes() {
	dialog --backtitle "Installing VM With kubernetes Please be patient!"\
	 --title "Installing kubernetes......" --clear\
	 --infobox "please wait while the vm is built and installed the job will start once you\
	  close this window.\n there is a log that you can view when it is finished. \n \
	  this can take a long time. be patient. :)" 40 90

	export FACTER_options='kubernetes';
	vagrant up 2>&1 | tee output.log
	vagrant reload

	dialog --backtitle "Installing VM With kubernetes COMPLETED!!"\
	 --title "Finished kubernetes Installation!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function add_Kubernetes() {
	dialog --backtitle "Installing VM With kubernetes Please be patient!"\
	 --title "Installing kubernetes......" --clear\
	 --infobox "please wait while the vm is built and installed the job will start once you\
	  close this window.\n there is a log that you can view when it is finished. \n \
	  this can take a long time. be patient. :)" 40 90

	vagrant reload
	export FACTER_options='kubernetes';
	vagrant provision 2>&1 | tee output.log
	vagrant reload

	dialog --backtitle "Installing VM With panamax COMPLETED!!"\
	 --title "Finished Installation!" --clear\
	  --msgbox "$(cat output.log)" 40 90
}

function add_intellij() {
	dialog --backtitle "Installing VM With Intellij Please be patient!"\
	 --title "Installing......" --clear\
	 --infobox "please wait while the vm is built and installed the job will start once you\
	  close this window.\n there is a log that you can view when it is finished. \n \
	  this can take a long time. be patient. :)" 40 90

	sed -e 's/gui = false/gui = true/g' Vagrantfiledefaultstuff
	vagrant reload
	export FACTER_options='intellij';
	vagrant provision 2>&1 | tee output.log
	vagrant reload

	dialog --backtitle "Installing VM With Intellij COMPLETED!!"\
	 --title "Finished Installation!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function install() {
	dialog --backtitle "Base VM Install Please be patient!"\
	 --title "Installing......" --clear\
	  --infobox "please wait while the vm is built and installed the job will start once you\
	   close this window.\n there is a log that you can view when it is finished. \n \
	   this can take a long time. be patient. :)" 40 90

	sed -e 's/gui = true/gui = false/g' Vagrantfile

	export FACTER_options='none';
	vagrant up 2>&1 | tee output.log
	vagrant reload

	dialog --backtitle "Base Install COMPLETED!!"\
	 --title "Finished Installation!" --clear\
	  --msgbox "$(cat output.log)" 40 90
}

function cleanInstall() {
    dialog --backtitle "Cleaning up install deleting VM Please be patient!"\
     --title "Installing......" --clear\
      --infobox "please wait while the vm is destroyed the job will start once you close\
       this window.\n there is a log that you can view when it is finished. \n \
       this can take a long time. be patient. :)" 40 90

	vagrant destroy --force 2>&1 | tee output.log

	dialog --backtitle "Clean Install COMPLETED!!"\
	 --title "Finished Cleanup!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function InstallLocalKubernetes() {
    dialog --backtitle "Cleaning up install deleting VM Please be patient!"\
     --title "Installing......" --clear\
      --infobox "Setting up your Kubernetes install in /opt :)" 40 90

	URL='https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
	git clone https://github.com/GoogleCloudPlatform/kubernetes.git /opt/kubernetes
	cd /opt/kubernetes

	export KUBERNETES_NUM_MINIONS=3

	vagrant up

	dialog --backtitle "Kubernetes Install COMPLETED!!"\
	 --title "Finished Install!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function InstallLocalPanamax() {
    dialog --backtitle "Cleaning up install deleting VM Please be patient!"\
     --title "Installing panamax locally" --clear\
      --infobox "This installs Along With The Development VM" 40 90

    if [ "$(expr substr $(uname -s) 1 5)" == "Darwin" ]; then
    	which -s brew
  		if [[ $? != 0 ]] ; then
    		ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  		else
    		brew update
  		fi

		if brew list -1 | grep -q "^panamax\$"; then
      		echo "Package 'panamax' is installed!"
  		else
      		brew install http://download.panamax.io/installer/brew/panamax.rb
      		echo "Package 'panamax' is now installed"
  		fi
  	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  		echo "Supporting Ubuntu Linux only for now."
  		sudo apt-get install unzip -y --force-yes
		URL='https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
		curl http://download.panamax.io/installer/ubuntu.sh | bash
  	fi
  	
  	panamax init


	dialog --backtitle "Clean Install COMPLETED!!"\
	 --title "Finished Cleanup!" --clear\
	 --msgbox "$(cat output.log)" 40 90
}

function LinkToDevelopmentProject() {
    dialog --backtitle "Creating a Development Env link"\
     --title "Create a Link" --clear\
      --infobox "Creating a link to your local project. If you want to work on your project or use the code from your local project; inside the vm, this is the place to be." 40 90

	dialog --inputbox "The Full path to the directory of your project:" 8 40 2>/tmp/input.$$

	path=`cat /tmp/input.$$`

	dialog --backtitle "Linking..." --title "Creating a Link" --infobox "creaing link to: ${path}" 40 90

	ln -s $path `pwd`/development

	dialog --backtitle "Linking COMPLETED!!" --title "Finished !" --msgbox "$(ls -alh `pwd`/development)" 40 90

    echo "RELOADING VM"
	vagrant reload
}

function viewlogs() {	
	dialog --textbox output.log 40 120
}


while true
do
 
dialog --clear --colors --help-button --backtitle "Linux Shell Script Tutorial" \
--title "[ D R U P A L D E P L O Y - M E N U ]" \
--menu "Welcome to the drupal deploy system \n\
The log is stored in /tmp/n \
use letter of the choice as a hot key, or the \
number keys 1-9 to choose an option.\n\n\
Choose from the options below" 25 80 30 \
StartVM "After you've installed use this to start" \
StopVM "Use this to shutdown your VM until later" \
RestartVM "Restart the VM this way remaps the synced folders" \
VagrantPlugins "Install the virtualbox guest additions manager" \
VMInstall "install vm with base options <HEADLESS>" \
Clean "Wipe out all the things and start fresh" \
Intellij "install vm with intellij" \
provisionIntellij "provision vm with intellij" \
EditVagrantfile "Edit the Vagrantfile" \
LinkToDevelopmentProject "Link to your local projet directory" \
ViewLog "View the installer log" \
SaveLog "View the installer log" \
Exit "Exit to the shell" 2>"${INPUT}"
 
menuitem=$(<"${INPUT}")
 
case $menuitem in
    StartVM) start_vm;;
    StopVM) stop_vm;;
    RestartVM) restart_vm;;
	VagrantPlugins) install_vagrant_plugins;;
	Intellij) install_intellij;;
	provisionIntellij) add_intellij;;
	VMInstall) install;;
	Clean) cleanInstall;;
	EditVagrantfile) $vi_editor Vagrantfile;;
	LinkToDevelopmentProject) LinkToDevelopmentProject;;
	ViewLog) viewlogs;;
	SaveLog) cp $OUTPUT ./SavedLog.log;;
	Exit) echo "Leaving the installer"; break;;
esac
 
done
 
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
