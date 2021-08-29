#!/bin/bash

option=$1
var=$2
file=$3

file_out="output/maping_sig.txt"
file_out2="output/asigned_sig.txt"
find_file="output/finded_sig.txt"
search_file="search_grep.txt"
temp_file="temp.txt"
file_in_lane="file_in_lane.txt"

#Option map
if [[ (("$option" == "-m") && ("$#" == 3))  ]]; then
  echo $var > $search_file
  echo $var > $find_file
  > $file_out

  while read -r line; do
    #Find port maps from searched signal
    grep -E "^((\s*\.\s*$line\s*\(\s*.*\s*\).*)|(\s*\.\s*.*\s*\(\s*$line\s*\).*))$" -rns $file --include=* .{sv,svh,v} > $temp_file
    
    #Avoid files already computed
    grep -v -f $file_out $temp_file > $file_in_lane #lines where execute new search for signal 
    cat $file_out  $file_in_lane >  $file_out
    
    #search new signals
    ./find_map_sig.exe $file_in_lane $search_file  $find_file $temp_file
    mv $temp_file $search_file #finded signals
  done < $search_file

  #Show results, remove temp files
  grep -f $find_file -rns $file --include=* .{sv,svh,v} > $file_out2
  #sort -u $file_out2 > $temp_file
  #mv $temp_file $file_out2
  echo "#####################"
  echo "#Signal asignations:#"
  echo "#####################"
  cat $file_out2
  echo "##################"
  echo "#Signal portmaps:#"
  echo "##################"
  cat $file_out
  echo "###############"
  echo "#Signal names:#"
  echo "###############"
  cat $find_file
  printf "\n"
  rm $file_in_lane
  rm $search_file
else
  echo -e "Usage:\n trace_signal.sh -m PATTERN FILE: Trace signal, get map and asignations\n"
fi
