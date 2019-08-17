
Log into the `web` container and inside the drupal folder run

```
composer require drupal/console:~1.0 \
--prefer-dist \
--optimize-autoloader --no-plugins --no-scripts
```

to install the Drupal console libraries for your drupal installation.

### Notes

#### Installation

Log into the web docker container and run

```
composer create-project drupal-composer/drupal-project:8.x-dev html --stability dev --no-interaction
```

inside the folder `/var/www/`, `html` will be created

#### Workaround

* attempt to create the directory ../config/sync failed, possibly due to a permissions problem

    * Comment line 788 : 
    ```
    #$config_directories['sync'] = '../config/sync';.
     ```
    * Add this line at the bottom 
   ``` 
    $config_directories = array(
     CONFIG_SYNC_DIRECTORY => 'sites/default/files/config_HASH',
     );
   ```

### Source

* [https://docs.drupalconsole.com/en/getting/composer.html](https://docs.drupalconsole.com/en/getting/composer.html)
* [https://www.drupal.org/docs/develop/using-composer/using-composer-to-manage-drupal-site-dependencies](https://www.drupal.org/docs/develop/using-composer/using-composer-to-manage-drupal-site-dependencies)
* [https://github.com/drupal-composer/drupal-project/issues/274](https://github.com/drupal-composer/drupal-project/issues/274)
