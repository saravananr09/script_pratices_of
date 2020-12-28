#!/bin/bash

db=("mariadb" "mysql" "mongo" "mssql")


#echo ${db[*]}
printf '%s\n' "${db[@]}" |  awk ' { awkArray[NR] = $1} END { for (i in awkArray) print awkArray[i], "\n"; }'
