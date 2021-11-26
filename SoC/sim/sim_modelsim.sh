#!/bin/bash

source ../config/set_var.sh

export file_list_dir=../file_list
export vlib_dir=../workspace

echo "start create library"
#create library
vlib $vlib_dir/work

echo "start add library"
#add library
vmap $vlib_dir/work

echo "start compile"
#compile
vlog -sv -64 -work $vlib_dir/work -f $file_list_dir/src_files.f

echo "start execute"
#execute
vsim $vlib_dir/work -t 10ns -64