#!/bin/bash

mariadbd --user=root &
child_pid=$!
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done


# Create the WordPress database and user
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $DB_NAME;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "MySQL setup completed successfully!"

kill "$child_pid"
