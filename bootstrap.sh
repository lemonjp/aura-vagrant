#!/usr/bin/env bash

# Update the box
# --------------
# Downloads the package lists from the repositories
# and "updates" them to get information on the newest
# versions of packages and their dependencies
apt-get update

# Manage system environment
echo "make bash pronpt shorter"
mv ~/.bashrc ~/.bashrc.dist
sed -e 's/\\u@\\h:\\w/\\u@\\h:\\W/g' ~/.bashrc.dist > ~/.bashrc

# Install Git
apt-get install -y git
# Install Ctags
apt-get install -y ctags
# Install Vim
apt-get install -y vim

# Set up Vim environment
echo "dotfile install"
cd ~/
git clone https://github.com/lemonjp/dotfiles.git
sh -x ./dotfiles/setup.sh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "set up vim env"
vim +BundleInstall +qall
cd ~/.vim/bundle/vimproc/
make -f make_unix.mak
cd ~/.vim/bundle/nerdtree/nerdtree_plugin
wget https://gist.github.com/lemonjp/2558f5cc63bcd347024b/raw/9e4f07818da3e9f98797710a9e78fd0d08ad79dc/grep_menuitem.vim

# Apache
# ------
# Install
apt-get install -y apache2
# Remove /var/www default
rm -rf /var/www
# Symlink /vagrant to /var/www
ln -fs /vagrant /var/www
# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/aura_project/web"
  ServerName localhost
  <Directory "/vagrant/aura_project/web">
    AllowOverride All
    Require all granted
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart

# PHP 5.5
# -------
apt-get install -y libapache2-mod-php5
# Add add-apt-repository binary
apt-get install -y python-software-properties
# Install PHP 5.4
add-apt-repository ppa:ondrej/php5
# Update
apt-get update

# PHP stuff
# ---------
# Command-Line Interpreter
apt-get install -y php5-cli
# MySQL database connections directly from PHP
apt-get install -y php5-mysql
# cURL is a library for getting files from FTP, GOPHER, HTTP server
apt-get install -y php5-curl
# Module for MCrypt functions in PHP
apt-get install -y php5-mcrypt
# JSON extension
apt-get install -y php5-json

# cURL
# ----
apt-get install -y curl

# Mysql
# -----
# Ignore the post install questions
export DEBIAN_FRONTEND=noninteractive
# Install MySQL quietly
apt-get -q -y install mysql-server-5.5

# Git
# ---
apt-get install -y git-core

# Install Composer
# ----------------
curl -s https://getcomposer.org/installer | php
# Make Composer available globally
mv composer.phar /usr/local/bin/composer

# Set up the database
echo "CREATE DATABASE IF NOT EXISTS aura_db" | mysql
echo "CREATE USER 'aura_user'@'localhost' IDENTIFIED BY 'pass123'" | mysql
echo "GRANT ALL PRIVILEGES ON aura_db.* TO 'aura_user'@'localhost' IDENTIFIED BY 'pass123'" | mysql

