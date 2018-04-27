FROM drupal:8.2-apache

MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get install -y lynx nano git curl mysql-client libpng12-dev libjpeg-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd

# Drush
RUN cd /usr/local/src && git clone https://github.com/drush-ops/drush.git \
      && cd /usr/local/src/drush \
      && git checkout -b 8.x origin/8.x \
      && composer install

RUN ln -s /usr/local/src/drush/drush /usr/local/bin/drush
