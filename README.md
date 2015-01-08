Drupal Deploy
==============
This is a drupal deploy development environment.
You can use this to test our your drupal environment deploys using docker and then push those same images to a testing, QA, and then on to Prod.
<br/><br/>
There are two modes, the headless mode from default install of VM or a desktop if you select intellij<br/><br/>
once you have deployed the HEADLESS option, you can access jenkins from http://localhost:8080 <br/>
You can also ssh into your machine and play with docker directly with vagrant ssh. <br/><br/>
The second mode enables the desktop, just select the intellij build option from the menu <br/>
if you want to enable desktop but you're not using the GUI in build.sh run:<br/><br/>
````
    sed -e 's/gui = false/gui = true/g' Vagrantfile
````
<br/><br/>
This project needs a couple more things before it does the deploy, right now it builds a docker container job as an example.
<br/><br/>
Here is the Trello Board for this project: https://trello.com/b/HYuONrC1
<br/><br/>
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

<br/> To keep your files synced in your development project run: vagrant rsync-auto
<br/>
<br/>