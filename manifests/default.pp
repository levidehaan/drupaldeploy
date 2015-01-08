node default {

  case $options {
    'intellij': {
      include installintellij
      include defaultstuff
      include desktop
      include google_chrome
    }

    default: {
      include randstuff
      include defaultstuff
      include jenkins
    }
  }
}

Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ] }

class installintellij {

  include randstuff
  include desktop
  include jenkins
  include google_chrome

  exec { 'run installintellij':
    command => '/puppet/intellijinst.sh',
    returns => [1, 0, 129],
    timeout => 5000,
  }

  exec { 'rm InstallIntelliJIdea.desktop':
    command => 'rm /home/vagrant/Desktop/InstallIntelliJIdea.desktop',
    require => Exec['run installintellij'],
  }

}

class defaultstuff {

  exec { 'apt-get update':
    command => 'apt-get update',
  }

  package {
    ["curl", "wget", "python", "python-pip", "python-crypto", "python-dev", "docker.io", "golang", "mercurial"]:
      ensure  => "installed",
      require => Exec['apt-get update'],
  }

  exec { 'setupdocker':
    command => 'ln -s `which docker.io` /usr/bin/docker',
    returns => [1,0],
    require => Package['curl'],
  }

}


class randstuff {

  augeas { "addfootosudoers":
    context => "/etc/sudoers",
    changes => [
      "set spec[user = 'jenkins']/user jenkins",
      "set spec[user = 'jenkins']/host_group/host all",
      "set spec[user = 'jenkins']/host_group/command all",
      "set spec[user = 'jenkins']/host_group/command/runas_user all",
    ],
  }
}

class desktop {

  package { ["kubuntu-desktop"]:
    ensure  => "installed"
  }

  exec { 'setupdesktop':
    command => 'cp /puppet/*.desktop /usr/share/applications/ -r',
    require => Package['kubuntu-desktop'],
    returns => [1, 0],
  }

  exec { 'setupdesktopicons':
    command => 'cp /puppet/*.desktop /home/vagrant/desktop/ -r',
    require => Package['kubuntu-desktop'],
    returns => [1, 0],
  }


}

