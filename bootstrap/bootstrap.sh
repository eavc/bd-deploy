#!/usr/bin/env bash

# =====================================
# PERFORMANCE SETTINGS (DISABLE?)
#echo "\033[1;34mOptimising performance settings\033[0m"
# For an official ISO Install:
#echo "0" | tee -a /sys/block/sda/queue/rotational &&
#echo "0" | tee -a /sys/block/sda/queue/rq_affinity &&
#echo "noop" | tee -a  /sys/block/sda/queue/scheduler &&
#echo "echo 0 > /sys/block/sda/queue/rotational" | tee -a /etc/rc.local &&
#echo "echo 0 > /sys/block/sda/queue/rq_affinity" | tee -a /etc/rc.local &&
#echo "echo noop > /sys/block/sda/queue/scheduler" | tee -a /etc/rc.local &&
#echo 'vm.swappiness=5' | tee -a /etc/sysctl.conf &&
#echo 'vm.vfs_cache_pressure=50' | tee -a /etc/sysctl.conf &&

# To potentially improve network performance:
#echo "net.core.rmem_max=16777216" | tee -a /etc/sysctl.conf &&
#echo "net.core.wmem_max=16777216" | tee -a /etc/sysctl.conf &&
#echo "net.ipv4.tcp_rmem=4096 87380 16777216" | tee -a /etc/sysctl.conf &&
#echo "net.ipv4.tcp_wmem=4096 65536 16777216" | tee -a /etc/sysctl.conf &&
#sysctl -p

#if [ $? -eq 0 ]
#then
#  echo "\033[1;32mSuccessfully optimised performance settings\033[0m"
#else
#  echo "\033[1;31mError optimising performance settings\033[0m"
#fi


# =====================================
# INSTALL PYTHON AND SOFTWARE PROPERTIES
echo "\033[1;34mInstalling python and python-software-properties\033[0m"
apt-get install -y python python-software-properties g++ make
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed python and python-software-properties\033[0m"
else
  echo "\033[1;31mError installing python and python-software-properties\033[0m"
fi

# =====================================
# ADD POSTGRESQL REPO
echo "\033[1;34mAdding PostgreSQL keys and repo\033[0m"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added PostgreSQL keys and repos\033[0m"
else
  echo "\033[1;31mError adding PostgreSQL keys and repos\033[0m"
fi

# =====================================
# ADD NODEJS PPA
echo "\033[1;34mAdding Node.js PPA\033[0m"
add-apt-repository ppa:chris-lea/node.js
# add-apt-repository ppa:chris-lea/nginx-devel
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added Node.js PPA\033[0m"
else
  echo "\033[1;31mError adding Node.js PPA\033[0m"
fi

# =====================================
# ADD ANSIBLE PPA
echo "\033[1;34mAdding Ansible PPA\033[0m"
add-apt-repository ppa:rquillo/ansible
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully added Ansible PPA\033[0m"
else
  echo "\033[1;31mError adding Ansible PPA\033[0m"
fi

# =====================================
# UPDATE SOURCES AND UPGRADE SOFTWARE
echo "\033[1;34mUpdating sources\033[0m"
apt-get update && apt-get upgrade -y
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully updated sources\033[0m"
else
  echo "\033[1;31mError updating sources\033[0m"
fi

# =====================================
# INSTALL SOFTWARE
echo "\033[1;34mInstalling software\033[0m"
apt-get install -y \
                htop \
				screen \
				aptitude \
				fail2ban \
				logwatch \
				git \
				unzip \
				build-essential \
				zlib1g-dev \
				libpcre3 \
				libpcre3-dev \
				libssl-dev \
				geoip-database \
				libgeoip-dev \
				libxslt-dev \
				libgd2-xpm-dev \
				postgresql-9.3 \
				pgadmin3 \
				postgresql-contrib \
				openssh-server \
				redis-server \
				curl \
				iperf \
				nodejs \
				ansible \
				upstart \
				monit \
				ntp \
				pwgen \
				mlocate \
				unattended-upgrades \
				checkinstall \

if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed software\033[0m"
else
  echo "\033[1;31mError installing software\033[0m"
fi

# =====================================
# INSTALL N FROM NPM AND STABLE NODEJS
echo "\033[1;34mInstalling n and Node.js\033[0m"
npm install n -g &&
n stable &&
# n ls

if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed n and Node.js\033[0m"
else
  echo "\033[1;31mError installing n and Node.js\033[0m"
fi

# =====================================
# CREATE NGINX USER
echo "\033[1;34mCreating Nginx user\033[0m"
adduser --system --no-create-home --disabled-login --disabled-password --group nginx

if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully created Nginx user\033[0m"
else
  echo "\033[1;31mError creating Nginx user\033[0m"
fi

# =====================================
# CREATE SOURCES DIR (IN HOME) AND DOWNLOAD NGINX SOURCES
echo "\033[1;34mDownloading Nginx sources, compiling, and installing Nginx\033[0m"
mkdir -p sources && cd sources &&
wget http://nginx.org/download/nginx-1.5.0.tar.gz  &&
tar xvf nginx-1.5.0.tar.gz &&
cd nginx-1.5.0 &&
mkdir vendor &&
cd vendor &&
git clone https://github.com/PiotrSikora/ngx_http_auth_request_module.git ngx_http_auth_request_module &&
wget http://people.freebsd.org/~osa/ngx_http_redis-0.3.5.tar.gz && tar -xzvf ngx_http_redis-0.3.5.tar.gz &&
git clone https://github.com/simpl/ngx_devel_kit.git ndk &&
git clone https://github.com/giom/nginx_accept_language_module.git &&
git clone https://github.com/gnosek/nginx-upstream-fair.git nginx-upstream-fair &&
git clone https://github.com/agentzh/echo-nginx-module.git echo-nginx-module &&
git clone https://github.com/pagespeed/ngx_pagespeed.git ngx_pagespeed &&
cd ngx_pagespeed && wget https://dl.google.com/dl/page-speed/psol/1.6.29.5.tar.gz && tar -xzvf 1.6.29.5.tar.gz &&
cd ../.. &&
./configure --prefix=/opt/nginx \
            --user=nginx \
            --group=nginx \
            --without-http_scgi_module \
            --without-http_uwsgi_module \
            --without-http_fastcgi_module \
            --prefix=/opt/nginx \
            --conf-path=/opt/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-client-body-temp-path=/var/lib/nginx/body \
            --http-log-path=/var/log/nginx/access.log \
            --http-proxy-temp-path=/var/lib/nginx/proxy \
            --lock-path=/var/lock/nginx.lock \
            --pid-path=/var/run/nginx.pid \
            --with-pcre-jit \
            --with-debug \
            --with-http_geoip_module \
            --with-http_gzip_static_module \
            --with-http_image_filter_module \
            --with-http_realip_module \
            --with-http_stub_status_module \
            --with-http_ssl_module \
            --with-http_sub_module \
            --with-http_xslt_module \
            --with-http_spdy_module \
            --with-ipv6 \
            --with-mail \
            --with-mail_ssl_module \
            --with-http_gzip_static_module\
            --add-module=$HOME/sources/nginx-1.5.0/vendor/ngx_http_auth_request_module \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/ngx_http_redis-0.3.5 \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/ndk \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/nginx_accept_language_module \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/nginx-upstream-fair \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/echo-nginx-module \
            --add-module=$HOME/sources/nginx-1.5.0/vendor/ngx_pagespeed &&
make -j 2 &&
checkinstall
#chown nginx:nginx /var/cache/nginx /usr/local/nginx/{fastcgi_temp,logs,proxy_temp}
if [ $? -eq 0 ]
then
  echo "\033[1;32mSuccessfully installed Nginx\033[0m"
else
  echo "\033[1;31mError installing Nginx\033[0m"
fi

