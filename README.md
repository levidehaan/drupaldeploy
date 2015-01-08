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
* `./installVagrant.sh`
* `./build.sh`

If you're using the desktop version and you want to keep your files synced in your development project run: `vagrant rsync-auto`

Your database information is:

Username: root <br/>
password: cheesedoodles <br/>
Host: DB (just DB, caps, in the host/ip area)

## In progress
Finished!
