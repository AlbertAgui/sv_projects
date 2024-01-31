#!/bin/bash

source ../config/set_var.sh

export file_list_dir=../file_list
export vlib_dir=../workspace

rm -rf ../workspace/work

#create library
vlib $vlib_dir/work

#add library
vmap $vlib_dir/work

#compile
vlog -sv -mfcu -64 -work $vlib_dir/work -f $file_list_dir/src_files.f &> comp_transcript.txt
#vlog -sv -64 -work $vlib_dir/work -f $file_list_dir/src_files.f &> comp_transcript.txt

#execute
vsim -c $vlib_dir/work.Top_test -t ps -64 -do "run 300ms" &> sim_transcript.txt
#vsim $vlib_dir/work.Top_test -t ps -64 -do wave.do -do "run 300ms"