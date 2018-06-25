#!/bin/bash

# change directory:
cd /var/www

# only if /typo3 is not et installed:
if  [ ! -f "/var/www/vendor/composer/installed.json" ];then
    echo -e "==================================="
    echo -e "== PREPARING INITIAL TYPO3-SETUP =="
    echo -e "==================================="
    # run composer update
    composer install

      # restore DB:
    typo3cms database:import < /var/www/ingredients/mysql/initialdump.sql

    # install DE-language
    typo3cms language:update --locales-to-update de

    # finally cache:flush
    typo3cms cache:flush

fi

# chown /var/www:
chown -R www-data:www-data /var/www

echo -e "==================================="
echo -e "==      CONTAINER IS READY       =="
echo -e "==================================="

exec "$@"
#/bin/bash