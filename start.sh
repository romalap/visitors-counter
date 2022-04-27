#!/bin/bash

function apt {
    sudo apt update
    sudo apt -y install apache2 redis-server php libapache2-mod-php php-redis
    sudo systemctl restart redis

    sudo cp counter.conf /etc/apache2/sites-available/
    sudo a2ensite counter
    sudo a2dissite 000-default
    sudo cp -r counter /var/www/
    sudo systemctl reload apache2
    return 0; }

function amazon {
    sudo amazon-linux-extras enable php7.4
    sudo yum clean metadata
    sudo yum -y install httpd php
    sudo amazon-linux-extras install -y redis6
    sudo yum -y install php-pecl-redis
    sudo systemctl restart redis

    sudo sed -i 's/\/var\/www\/html/\/var\/www\/counter/g' /etc/httpd/conf/httpd.conf
    sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/' /etc/httpd/conf/httpd.conf
    sudo cp -r counter /var/www/
    sudo systemctl restart httpd
    return 0; }

function rhel {
    sudo yum -y install yum-utils
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
    sudo yum -y module enable php:remi-7.4
    sudo yum -y install httpd redis php php-pecl-redis5
    sudo systemctl restart redis

    sudo cp -r counter/* /var/www/html
    sudo setenforce 0
    sudo systemctl restart httpd
    return 0; }

function zypper {
    sudo zypper ref
    sudo zypper in -y apache2 redis php php7-fpm apache2-mod_php7
    sudo wget https://download.opensuse.org/repositories/openSUSE:/Factory/standard/x86_64/php7-redis-5.3.7-1.1.x86_64.rpm
    sudo rpm -ivh php7-redis-5.3.7-1.1.x86_64.rpm
    sudo a2enmod php7

    sudo cp /etc/redis/default.conf.example /etc/redis/redis.conf
    sudo chown redis.redis /etc/redis/redis.conf
    sudo sed -i 's/default.pid/redis-server.pid/' /etc/redis/redis.conf
    sudo cp redis.service /etc/systemd/system/redis.service
    sudo systemctl restart redis

    sudo cp counter_suse.conf /etc/apache2/vhosts.d/counter.conf
    sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/' /etc/apache2/httpd.conf
    sudo cp -r counter /srv/www/htdocs
    sudo systemctl restart apache2
    return 0; }

if [[ `which yum` ]]; then
    if [[ ! "cat /etc/os-release | grep 'Amazon Linux'" ]]; then amazon
    else rhel
    fi
elif [[ `which apt` ]]; then apt

elif [[ `which zypper` ]]; then zypper

else
   echo OS_UNKNOWN
fi

