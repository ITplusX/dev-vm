yum clean all
yum makecache fast
yum -y update

# Configure yum to install "all" packages while running group installations
echo "group_package_types=default, mandatory, optional" >> /etc/yum.conf

# 
yum -y groupinstall "Development Tools"

# Install/update virtualbox gues additions "manually"
# yum -y install epel-release
# yum -y install kernel-devel
# wget http://download.virtualbox.org/virtualbox/4.3.24/VBoxGuestAdditions_4.3.24.iso
# mkdir /media/VBoxGuestAdditions
# mount -o loop,ro VBoxGuestAdditions_4.3.24.iso /media/VBoxGuestAdditions
# sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
# rm VBoxGuestAdditions_4.3.24.iso
# umount /media/VBoxGuestAdditions
# rmdir /media/VBoxGuestAdditions
# yum -y remove epel-release

# Install MySQL aka MariaDB
yum -y install mariadb-server mariadb
systemctl start mariadb.service
systemctl enable mariadb.service

# Install webserver and libraries
yum -y groupinstall "Web Server" "PHP Support"
yum -y install php-devel php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel
yum -y install ImageMagick ImageMagick-devel
pecl channel-update pecl.php.net
pecl install Imagick
echo "extension=imagick.so" >> /etc/php.ini
# Set timezone to php.ini
sed -i 's/;date.timezone =/date.timezone = \"Europe\/Berlin\"/g' /etc/php.ini
systemctl start httpd.service
systemctl enable httpd.service

# Install usefull packages
yum -y install vim tmux screen bind-utils net-tools

# Disable selinux as we are in a dev environment
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

# Install oh my zsh
yum -y install zsh
#curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Open firewall for some services
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload