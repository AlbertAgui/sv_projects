#!/bin/bash

option=$1
var=$2
file=$3
file_out="signal_lines.txt"
find_file="signal_finded.txt"
search_file="search_grep.txt"
temp_file="temp.txt"
temp2_file="temp2.txt"
file_in_lane="file_in_lane.txt"
if [[ (("$option" == "-i") && ("$#" == 3))  ]]; then
  echo $var > $search_file
  echo $var > $find_file
  > $file_out
  while [ -s $search_file ]; do	  
    grep -nrs $file -f $search_file --include=*.{sv,v,svh} > $temp_file#--include *.{sv,v,svh} > $temp_file
    grep -v -f $file_out $temp_file > $file_in_lane
    cat $file_out  $file_in_lane >  $temp_file
    mv $temp_file $file_out
    ./find_map_sig.exe $file_in_lane $search_file  $find_file $temp_file
    mv $temp_file $search_file
  done
  sort -u $file_out > $temp_file
  mv $temp_file $file_out
  cat $file_out
  rm $file_in_lane
  rm $search_file

elif [[ (("$option" == "-add") && ("$#" == 2)) ]];then
  grep -e $var -rns . --include *.{sv,v,svh} >> $file
  cat $file
elif [[ (("$option" == "-rm") && ("$#" == 2)) ]];then
  grep -v $var $file > $tmp_file
  mv $tmp_file $file
  cat $file
else
  echo -e "Usage:\n find.sh -i PATTERN FILE: first recursive search, \n find.sh -add PATTERN: next search\n"
fi
