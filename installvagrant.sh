#!/bin/bash

if [ "$(expr substr $(uname -s) 1 5)" == "Darwin" ]; then
    which -s brew
  if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  else
    brew update
  fi

  
  if brew list -1 | grep -q "^dialog\$"; then
      echo "Package 'dialog' is installed"
  else
      brew install dialog
      echo "Package 'dialog' is now installed"
  fi

  if brew list -1 | grep -q "^wget\$"; then
      echo "Package 'wget' is installed"
  else
      brew install wget
      echo "Package 'wget' is now installed"
  fi

  if ! which vagrant > /dev/null; then
      echo -e "vagrant not found! Install? (y/n) \c"
      read
    if "$REPLY" = "y"; then
      wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg
      hdiutil mount vagrant_1.6.3.dmg
    fi
  fi        
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if ! which vagrant > /dev/null; then
    echo -e "vagrant not found! Install? (y/n) \c"
    read
    if "$REPLY" = "y"; then
       wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb
       sudo dpkg -i vagrant_1.6.3_x86_64.deb
    fi
  fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo "This MIGHT work with cygwin"
  if ! which vagrant > /dev/null; then
    echo -e "vagrant not found! Install? (y/n) \c"
    read
    if "$REPLY" = "y"; then
       wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.msi
       msiexec /I vagrant_1.6.3.msi
    fi
  fi

fi
