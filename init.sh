#!/bin/bash

if [ ! -f ./.loaded ]; then
  cp -Rf /drupal-8.x/. /var/www/html/
  chmod 777 /var/www/html/sites/default/files  
  chmod 777 /var/www/html/sites/default/settings.php 
 touch ./.loaded
fi

bash -c "apachectl -D FOREGROUND"
