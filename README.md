Drupal Deploy
==============
<br/>
You can install Vagrant with the installVagrant.sh script.<br/>
./installVagrant.sh<br/>
<br/>
This will install (if you dont have them):
* Brew ( http://brew.sh/ )
* Vagrant ( http://www.vagrantup.com/ )
* Dialog ( http://mathscoding.blogspot.com/2013/09/use-dialog-to-add-simple-gui-to-bash.html to install by hand ''' brew install dialog ''' )
* wget ( man wget )
<br/>
<br/>
Run ./build.sh in order to access the main installation program after you have installed the above requisite files.

You may need to run:

chown jenkins:jenkins /jenkins -R

if you have any issues with Jenkins running its jobs.
