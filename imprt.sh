#!/bin/bash

set -x
BACKUP_DIR="/home/saravanan/mysql-base/bkupsfrom/11-01-2021"
MYSQL_USER="root"
#pass
MYSQL="/home/saravanan/mysql-base/bin/mysql -u root -S /tmp/mysql10.sock"


dbc=`ls -l $BACKUP_DIR | grep -v ^total | awk '{print $9}' | wc -l`

i=1

while [ $i -le $dbc ]
do

impdb=`ls -l $BACKUP_DIR | grep -v ^total | head -$i | tail -1 | awk '{print $9}'`

echo "Import started for $i for file $impdb" >>importstats.err

$MYSQL  < "$BACKUP_DIR/$impdb"  2>$impdb.err

  if [ ! -s $impdb.err ]
        then
            rm $impdb.err
     echo -e "Import completed successfully for the file $impdb" >>finstats.err
      else
  err=$(cat $impdb.err)
         echo -e "Error is $err for file $impdb" >>finstats.err

    fi
   ((i++))
   
done




