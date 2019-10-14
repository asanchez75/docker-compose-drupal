FROM php:7.1-apache
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>

VOLUME /var/www/html

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev openssl libssl-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip \
	&& docker-php-ext-install opcache bcmath soap ftp mysqli \
	&& a2enmod rewrite \
	&& rm -rf /var/lib/apt/lists/*

COPY drupal-*.ini /usr/local/etc/php/conf.d/

# Add if the document root of the Drupal installation will be  /var/www/html/web
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update && apt-get install -y mariadb-client

