#!/bin/bash

if [[ ! -d /home/ldurieux/data/mysql ]]; then
	echo "installing mariadb"
    mysql_install_db > /dev/null 2>&1
    /usr/bin/mysqld_safe > /dev/null 2>&1 &

	RET=1
	while [[ RET -ne 0 ]]; do
	    echo "waiting for service"
	    sleep 2
	    mysql -uroot -e "status" > /dev/null 2>&1
	    RET=$?
	done

	echo "initializing db"
	mysql -uroot -e "CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
	mysql -uroot -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION"

	mysql -uroot -e "CREATE DATABASE wordpress"

	echo "done"

	mysqladmin -uroot shutdown
fi

echo "running"
exec mysqld_safe --defaults-file=/etc/mysql/my.cnf
