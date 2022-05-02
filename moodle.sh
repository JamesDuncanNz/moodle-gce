# Update and Upgrade Host
sudo apt update -y
sudo apt upgrade -y

# sudo apt-get install -y wget php-pgsql apache2 php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-ldap php-zip php-curl
sudo apt install wget -y php7.4 libapache2-mod-php php-pgsql graphviz aspell ghostscript clamav php7.4-pspell php7.4-curl php7.4-gd php7.4-intl php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-ldap php7.4-zip php7.4-soap php7.4-mbstring
wget https://download.moodle.org/download.php/direct/stable400/moodle-4.0.tgz -P /tmp
sudo tar -xzvf /tmp/moodle-4.0.tgz -C /var/www/html

# Make filesystem changes
sudo mkdir -p /var/www/html/moodledata
sudo mkdir -p /var/moodledata
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 777 /var/www/
sudo chmod -R 777 /var/moodledata

# Restart Apache2
sudo systemctl stop apache2.service
sudo systemctl start apache2.service

# Copy moodle config from gcs
sudo gsutil cp gs://jdnz-moodle-config/config.php /var/www/html/moodle/

# Pull down apache config
sudo gsutil cp gs://jdnz-moodle-config/moodle.conf /etc/apache2/sites-available/

#Enable Moodle site
cd /etc/apache2/sites-available
sudo a2ensite ./moodle.conf

sudo systemctl reload apache2.service
sudo systemctl enable apache2.service
