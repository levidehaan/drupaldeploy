#!/usr/bin/env bash

download()
{
	apt-get -f install -y
	sudo apt-get install wget -y
    local url=$1
    echo -n "    "
    wget --progress=dot $url 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo " DONE"
}

mkdir /home/vagrant/ideaIU

echo -n "Downloading Intellij"
download "http://download-cf.jetbrains.com/idea/ideaIU-13.1.4b.tar.gz"

sudo tar -xvf ideaIU-13.1.4b.tar.gz -C /home/vagrant/ideaIU
