#!/bin/bash
## Usage: ./extract_label_memento.sh status_id
##
## @Kritika_garg
## Date: 2020-11-21
##
status_id=$1
mkdir $status_id
MYURL='https://twitter.com/realDonaldTrump/status/'$status_id

curl -s curl -s http://memgator.cs.odu.edu/timemap/link/$MYURL > $status_id/memgator_res$status_id 
curl -s https://web.archive.org/cdx/search/cdx?url=$MYURL > $status_id/cdx_res$status_id 
cat $status_id/cdx_res$status_id| awk -F" " '$5=="200" && $7> 40000 {print}' | cut -d" " -f2 > $status_id/URMs$status_id


while read DT; do
	#echo $DT
	URM='https://web.archive.org/web/'$DT'/'$MYURL
	curl -s $URM > $status_id/temp_$DT.html
	TL=$(grep '  <span class="Tombstone-label">        <span class="Tombstone-label">' $status_id/temp_$DT.html | cut -d'<' -f3)
	echo -e $DT"\t"$TL >> $status_id/oldUImementos_$status_id
	# if test -z "$eng"; then
	# 	break
	#fi	

done < $status_id/URMs$status_id


#convert label into true false based on characters (label length)
#$ awk -F'\t' '{ if(length($2)<=150){print $1"\tFALSE"} else{ print$1"\tTRUE"}}' blog3/1266231100780744704/oldUImementos_1266231100780744704 > blog3/1266231100780744704/oldUImementos_1266231100780744704_logical.tsv
