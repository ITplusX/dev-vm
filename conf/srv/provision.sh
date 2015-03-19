#!/bin/bash

# Prepare yum
yum clean all
yum makecache fast
# Install delta RPMs, because we are based on a minimal installation.
yum -y provides '*/applydeltarpm'
yum -y update

# Install EPEL and REMI repos
yum -y install http://mirror.23media.de/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Configure yum to install "all" packages while running group installations
echo "group_package_types=default, mandatory, optional" >> /etc/yum.conf

# Install dev tools
yum -y groupinstall "Development Tools"

# Install usefull packages
yum -y install vim tmux screen bind-utils net-tools

# Install MySQL aka MariaDB
yum -y install mariadb-server mariadb
systemctl start mariadb
systemctl enable mariadb

# Install webserver and libraries
yum -y install curl curl-devel
yum -y install ImageMagick ImageMagick-devel
yum -y groupinstall "Web Server" --exclude=mod_security --exclude=mod_evasive --exclude=mod_security_crs
yum-config-manager --enable remi
yum -y install php56-php php56-php-fpm php56-php-devel php56-php-gd php56-php-ldap php56-php-pear php56-php-xml php56-php-xmlrpc php56-php-mbstring php56-php-soap php56-php-mcrypt php56-php-opcache php56-php-pecl-xdebug php56-php-pecl-imagick php56-php-pecl-memcache php56-php-pecl-memcached
# Disable stupid default www.conf of php-fpm
cat /dev/null > /opt/remi/php56/root/etc/php-fpm.d/www.conf
ln -s /vagrant/conf/php/php-fpm.conf /opt/remi/php56/root/etc/php-fpm.d/local.conf
ln -s /vagrant/conf/php/php.ini /opt/remi/php56/root/etc/php.d/99-local.ini
ln -s /vagrant/conf/httpd/virtual-host-80.conf /etc/httpd/conf.d/virtual-host-80.conf
ln -s /vagrant/conf/httpd/virtual-host-443.conf /etc/httpd/conf.d/virtual-host-443.conf
ln -s /usr/bin/php56 /usr/local/bin/php

# Disable selinux now to make our life livable again
setenforce 0
# Disable selinux as we are in a dev environment
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Start and enable apache/php-fpm
systemctl enable httpd
systemctl start httpd
systemctl enable php56-php-fpm
systemctl start php56-php-fpm

# Install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install node.js
yum -y install nodejs
yum -y install npm

# Install global nope packages
npm install -g bower
npm install -g inherits
npm install -g grunt-cli

# Install oh-my-zsh
yum -y install zsh
# setup oh-my-zsh
if [ ! -f /home/vagrant/.oh-my-zsh/ ]; then
	sudo -u vagrant -H git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
fi
sudo -u vagrant -H ln -s /vagrant/conf/zsh/.zshrc /home/vagrant/.zshrc
chsh -s $(which zsh) vagrant

# Open firewall for some services
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# We have to reboot to set the selinux setting
echo "You have to run 'vagrant reload' from your host to complete setup."