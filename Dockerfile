FROM php:7.1-apache
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>

VOLUME /var/www/html/web

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev openssl libssl-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip \
	&& docker-php-ext-install opcache bcmath soap ftp mysqli \
	&& a2enmod rewrite \
	&& rm -rf /var/lib/apt/lists/*

COPY drupal-*.ini /usr/local/etc/php/conf.d/

# Add if the document root of the Drupal installation will be  /var/www/html/web
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Installation of compass
RUN apt-get update && \
    apt-get install -y git ruby-full && \
    gem install --no-rdoc --no-ri sass -v 3.4.22 && \
    gem install --no-rdoc --no-ri compass -v 1.0.3 && \
    gem install susy -v 2.2.14 && \
    gem install bootstrap-sass -v 3.3.7 && \
    gem install font-awesome-sass --version 4.7.0

# Installation of Composer
RUN cd /usr/src && curl -L -O https://getcomposer.org/composer.phar
RUN cd /usr/src && mv composer.phar /usr/bin/composer && chmod u+x /usr/bin/composer

# Installation of drush 7
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
RUN cd /usr/local/src/drush && git checkout -b 8.1.16 8.1.16
RUN ln -s /usr/local/src/drush/drush /usr/bin/drush
RUN cd /usr/local/src/drush && composer update && composer install

RUN apt-get update && apt-get install -y mariadb-client

# Drupal
RUN cd / && composer create-project drupal-composer/drupal-project:8.x-dev /drupal-8.x --stability dev --no-interaction && \
    cd /drupal-8.x/web && composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader --no-plugins --no-scripts

COPY init.sh /init.sh

RUN chmod u+x /init.sh

CMD ["/init.sh"]
