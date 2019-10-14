#!/bin/bash

if [ ! -f ./.loaded ]; then
  cp -Rf /drupal-8.x/. /var/www/html/
  touch ./.loaded
fi

bash -c "apachectl -D FOREGROUND"
