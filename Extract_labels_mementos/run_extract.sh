#!/bin/bash

while read status_id; do
	nohup extract_label_memento.sh $status_id &
done < voilatedlabeltweet_ids.txt


##convert label into true false based on character length(label length)- remove other tombstone labels.
# while read status_id; do
# 	file=$status_id/oldUImementos_$status_id 
# 	((COUNTER++))
# 	awk -F'\t' '{ if(length($2)<=150){print $1"\tFALSE"} else{ print$1"\tTRUE"}}' $file |sed 's/$/\t'$COUNTER/  >> oldUImementos_all_logical.tsv
# done < voilatedlabeltweet_ids.txt