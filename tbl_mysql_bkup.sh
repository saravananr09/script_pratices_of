#!/bin/bash
#set -x
DATE=$(date +%d-%m-%Y)
backup_path="/home/saravanan/script_pratices_of/bkups"
MYSQL_USER="root"
MYSQL_PASSWORD=""
MYSQL=/home/saravanan/mysql-base/bin/mysql
MYSQLDUMP=/home/saravanan/mysql-base/bin/mysqldump
SOCKET=/tmp/mysql06.sock
DB_name=sakila
error="/tmp/bkp.err"


tables=(address actor actor_info)


for tbl in ${!tables[@]}
do 	
	echo ${tables[$tbl]};
	echo $DB_name;
	$($MYSQLDUMP -u$MYSQL_USER -S$SOCKET --max-allowed-packet=100M --quick --single-transaction --databases $DB_name --tables ${tables[$tbl]} | gzip -c >$backup_path/${tables[$tbl]}-${DATE}.sql.gz 2>$error ) &
sleep 10
done


echo "The backup for the given tables are finished "














