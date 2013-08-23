#!/usr/bin/env bash

echo "\033[1;34mUpdating sources\033[0m"
apt-get update
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully updated sources\033[0m"
else
  echo "\033[1;31mError updating sources\033[0m"
fi

echo "\033[1;34mInstalling python and python-software-properties\033[0m"
apt-get install -y python python-software-properties g++ make
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed python and python-software-properties\033[0m"
else
  echo "\033[1;31mError installing python and python-software-properties\033[0m"
fi

echo "\033[1;34mAdding PostgreSQL keys and repos\033[0m"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added PostgreSQL keys and repos\033[0m"
else
  echo "\033[1;31mError adding PostgreSQL keys and repos\033[0m"
fi


echo "\033[1;34mAdding Node.js PPA\033[0m"
add-apt-repository ppa:chris-lea/node.js
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added Node.js PPA\033[0m"
else
  echo "\033[1;31mError adding Node.js PPA\033[0m"
fi


echo "\033[1;34mAdding Ansible PPA\033[0m"
add-apt-repository ppa:rquillo/ansible
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added Ansible PPA\033[0m"
else
  echo "\033[1;31mError adding Ansible PPA\033[0m"
fi

echo "\033[1;34mUpdating sources\033[0m"
apt-get update
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully updated sources\033[0m"
else
  echo "\033[1;31mError updating sources\033[0m"
fi

echo "\033[1;34mInstalling software\033[0m"
apt-get install -y \
                htop \
				screen \
				aptitude \
				fail2ban \
				logwatch \
				git \
				build-essential \
				postgresql-9.2 \
				postgresql-contrib \
				pgadmin3 \
				libssl-dev \
				curl \
				nodejs \
				ansible \
				upstart \
				monit \
				unattended-upgrades
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed software\033[0m"
else
  echo "\033[1;31mError installing software\033[0m"
fi


echo "\033[1;34mInstalling n and Node.js\033[0m"
npm install n -g &&
n stable &&
n ls

if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed n and Node.js\033[0m"
else
  echo "\033[1;31mError installing n and Node.js\033[0m"
fi

