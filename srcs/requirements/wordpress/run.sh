#!/bin/bash

if [[ ! -d /home/ldurieux/data/wp-admin ]]; then

    echo "installing wp-cli"
    cd /home/ldurieux/
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    echo "downloading wordpress"
    ./wp-cli.phar --allow-root --path=data core download
    chown -R www-data:www-data data/

    echo "waiting for db"
    sleep 25

    echo "installing wordpress"
    ./wp-cli.phar --allow-root --path=data config create \
        --dbname='wordpress' \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost='mariadb'
    ./wp-cli.phar --allow-root --path=data core install \
        --url="$DOMAIN_NAME" \
        --title='ldurieux website' \
        --admin_user='ldurieux' \
        --admin_password='ldurieux' \
        --admin_email='ldurieux@student.42lyon.fr'
    ./wp-cli.phar --allow-root --path=data user create 'test_user' 'test_user@student.42lyon.fr' \
        --user_pass='test_user' \
        --role='editor'

    echo "done"
fi

echo "running"
exec /usr/sbin/php-fpm7.3 --nodaemonize