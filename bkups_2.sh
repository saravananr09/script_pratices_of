#!/bin/bash

set -x
DATE=$(date +%d-%m-%Y)
BACKUP_DIR=/home/saravanan/mysql-base/bkupsfrom
MYSQL_USER="root"
MYSQL=/home/saravanan/mysql-base/bin/mysql
MYSQLDUMP=/home/saravanan/mysql-base/bin/mysqldump

mkdir -p $BACKUP_DIR/$DATE

databases=`$MYSQL -u$MYSQL_USER -S /tmp/mysql06.sock -e "SHOW DATABASES;" | grep -Ev "(Database|test|mysql)"`

for db in $databases; do
$MYSQLDUMP -u$MYSQL_USER -S /tmp/mysql06.sock --max-allowed-packet=100M --quick --single-transaction --complete-insert  --databases $db > "$BACKUP_DIR/$DATE/$db.sql" 2>$db.err

  if [ ! -s $db.err ]
        then
          rm $db.err
        else
         echo -e "Please check the error " >>out.err

   fi
done
