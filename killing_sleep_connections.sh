#!/bin/bash
#set -x
thres=4;
sleep_con=$(mysql -u root -S /tmp/mysql06.sock -sN -e "SELECT count(*) FROM information_schema.processlist WHERE COMMAND in ('Query');");
query_ids=($(mysql -u root -S /tmp/mysql06.sock -sN -e "SELECT ID FROM information_schema.processlist WHERE COMMAND in ('Query');"))

#echo "${query_ids[@]}"
#echo "$sleep_con"


if [ "$sleep_con" -gt "$thres" ]
then
	#echo "con success!"
	for kill in ${!query_ids[@]}
	do
		mysql -u root -S /tmp/mysql06.sock -sN -e "kill ${query_ids[$kill]};";
		sleep 0.1	
		echo "query no $(($kill+1)) and id is ${query_ids[$kill]} and killed it !  ";
	done
	
fi

