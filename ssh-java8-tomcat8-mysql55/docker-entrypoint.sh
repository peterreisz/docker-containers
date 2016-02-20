#!/bin/bash

[ -z "$OS_USER" ] && OS_USER="os_user"
[ -z "$OS_PASS" ] && OS_PASS="os_pass"
[ -z "$DB_USER" ] && DB_USER="db_user"
[ -z "$DB_PASS" ] && DB_PASS="db_pass"

# Init mysql if there is no data dir
DATADIR="$(mysqld --verbose --help --log-bin-index=`mktemp -u` 2>/dev/null | awk '$1 == "datadir" { print $2; exit }')"
if [ ! -d "$DATADIR/mysql" ]; then
    echo "Init database..."
    mysql_install_db --user mysql

    # TODO: set db root password?
    #echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
fi

# Create db user if not exists
if [ ! -d "$DATADIR/$DB_USER" ]; then
    echo "Create database..."

    mysqld &

    for i in {30..0}; do
        if echo 'SELECT 1' | "mysql" &> /dev/null; then
            break
        fi
        echo 'MySQL init process in progress...'
        sleep 1
    done
    if [ "$i" = 0 ]; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi

    echo "CREATE DATABASE IF NOT EXISTS $DB_USER CHARACTER SET utf8;" | mysql
    echo "GRANT ALL PRIVILEGES ON $DB_USER.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" | mysql

    mysqladmin shutdown
fi


# Create os user if not exists
if id -u $OS_USER >/dev/null 2>&1; then
    echo "User $OS_USER already exists"
else
    echo "Create user $OS_USER..."
    useradd -ms /bin/bash $OS_USER
    echo -e "$OS_PASS\n$OS_PASS" | passwd $OS_USER
    gpasswd -a $OS_USER sudo
fi

export JRE_HOME=/opt/java
sudo chown -R tomcat /opt/tomcat
sed -i -e"s/^chown.*/chown=$OS_USER:$OS_USER/" /etc/supervisor/conf.d/supervisord.conf

exec "$@"



