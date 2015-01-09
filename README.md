Drupal Deploy
==============
This is a drupal deploy development environment.

You can use this to test our your drupal environment deploys using docker and then push those same images to a testing, QA, and then on to Prod.

There are two modes, the headless mode from default install of VM or a desktop if you select intellij

Once you have deployed the HEADLESS option, you can access jenkins from http://localhost:8080
You can also ssh into your machine and play with docker directly with vagrant ssh.

The second mode enables the desktop, just select the intellij build option from the menu.
If you want to enable desktop but you're not using the GUI in build.sh run:
```
sed -e 's/gui = false/gui = true/g' Vagrantfile
```

## Installation
Run the following:
* `git checkout git@github.com:levidehaan/drupaldeploy.git`
* `./installVagrant.sh (this is primarily for mac's, you can use these tools on MLW )`
* `./build.sh`

If you have a problem running installVagrant.sh here is a list of what it installs and how to install by hand:

Install homebrew if it's not installed:

`ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`


Install a lib called [Dialog](http://hightek.org/projects/dialog/ "Dialog") using this command:<br/>
<i>You may be able to install this on windows, but it'd be a bit of a pita.</i>

`brew install dialog`

Install a tool called wget

`brew install wget`

it then installs vagrant if it's not installed using this command (I've included all 3 operating systems):

Mac:

`wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg`
`hdiutil mount vagrant_1.6.3.dmg`

Linux (Debian):

`wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb`
`sudo dpkg -i vagrant_1.6.3_x86_64.deb`

Windows:

`wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.msi`
`msiexec /I vagrant_1.6.3.msi`


## Setting up Drupal

Once you have built your docker container and run the deploy go to

http://localhost:8080/

Once you get to the database setup your database information is (you can use root user or drupal user):

Username: root -|- drupal<br/>
password: cheesedoodles -|- cheese<br/>
Host: DB (just type DB in the host/ip area, it will use the env var passed by --link)

## In progress

Finished! for now...

## Misc

If you're using the desktop version and you want to keep your files synced in your development project run: `vagrant rsync-auto`
