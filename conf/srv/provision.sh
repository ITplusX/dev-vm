yum clean all
yum makecache fast
yum -y update

# Configure yum to install "all" packages while running group installations
echo "group_package_types=default, mandatory, optional" >> /etc/yum.conf

# 
yum -y groupinstall "Development Tools"

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
systemctl start httpd.service
systemctl enable httpd.service

# Install usefull packages
yum -y install vim tmux screen bind-utils net-tools

# Disable selinux as we are 
setenforce 0

# Install oh my zsh
yum -y install zsh
#curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Open firewall for some services
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload