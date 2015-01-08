Drupal Deploy
==============
This is a drupal deploy development environment.
You can use this to test our your drupal environment deploys using docker and then push those same images to a testing, QA, and then on to Prod.
<br/>
<br/>
This project needs a couple more things before it does the deploy, right now it builds a docker container job as an example.
<br/>
-It still needs to run the docker container<br/>
-It still needs to deploy the docker container locally<br/>
<br/>
These will be added next.<br/>
<br/>
<br/>
To get started you can install Vagrant with the installVagrant.sh script.<br/>
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
