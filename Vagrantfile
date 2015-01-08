# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

#Create needed directories
mkdir /home/vagrant/Desktop

#copy data to the right places
cp /puppet/*.desktop /home/vagrant/Desktop -R -u -b

#setting ownership on directories
chown vagrant:vagrant /home/vagrant/Desktop

#changing mirror location to a nearby location
sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/mirror.nexcess.net/g' /etc/apt/sources.list

#install these packages now
sudo apt-get install unzip git libpango1.0-dev curl wget net-tools -y --force-yes

#install these puppet modules

puppet module install puppetlabs-apt --force
puppet module install puppetlabs-stdlib --force
puppet module install garethr-docker --force
puppet module install jamesnetherton-google_chrome --force
puppet module install maestrodev-wget --force
puppet module install puppetlabs-java --force
puppet module install rtyler/jenkins --force

SCRIPT

$script2 = <<SCRIPT

docker pull ubuntu:14.04

#adding nsenter
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

#installing fig for docker
pip install fig

#installing Brackets
URL='https://github.com/adobe/brackets/releases/download/release-1.1%2Beb4/Brackets.1.1.Extract.64-bit.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE

#Desktop has been installed change ownership of files
chown vagrant:vagrant -R /home/vagrant/Desktop

#jenkins plugins
chown jenkins:jenkins /jenkins -R
cp /jenkins/plugins/* /var/lib/jenkins/plugins/ -R
chown jenkins:jenkins /var/lib/jenkins -R

#jenkins jobs
rm /var/lib/jenkins/jobs -rf
ln -s /jenkins/jobs /var/lib/jenkins/jobs
chown jenkins:jenkins /var/lib/jenkins -R
chown jenkins:jenkins /jenkins -R
chown jenkins:jenkins -R /development

echo '%jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

echo "Completed Setup!"
echo "Go to http://localhost:8080/ to access jenkins"
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder "./development", "/development", type: "rsync"
  config.vm.synced_folder "./puppet", "/puppet", type: "rsync"
  config.vm.synced_folder "./jenkins", "/jenkins", type: "rsync", rsync__exclude: ".git"

  config.vm.box = "ubuntuphusion"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.hostname = "DrupalDevEnv"

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081

  config.vm.provider :virtualbox do |vb, override|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    vb.gui = false

    vb.customize ["modifyvm", :id, "--memory", 4098]
    vb.customize ["modifyvm", :id, "--cpus", 4]


    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/puppet", "1"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/jenkins", "1"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/development", "1"]

    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]

  end

  config.vm.provision "shell", privileged: true, inline: $script, args: "#{ENV['FACTER_options']}"

  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose --debug"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    FACTER_options=ENV['FACTER_options']
    puppet.facter = {
        "options" => "#{FACTER_options}"
    }
  end

  config.vm.provision "shell", privileged: true, inline: $script2, args: "#{ENV['FACTER_options']}"

end
