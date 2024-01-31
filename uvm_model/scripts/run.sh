#!/bin/bash

export file_list_dir=../file_list
export vlib_dir=../workspace
export include_dir=../include

echo "compile dpi-c"
gcc -c -g -I$include_dir -fPIC ../src_c/SumClass.cc -o SumClass.o
gcc -c -g -I$include_dir -fPIC ../src_c/SumClass_dpi.cc -o SumClass_dpi.o
gcc -shared SumClass.o SumClass_dpi.o -o $vlib_dir/SumClass.so
rm SumClass.o
rm SumClass_dpi.o

echo "start create library"
#create library
vlib $vlib_dir/work

echo "start add library"
#add library
vmap $vlib_dir/work

echo "start compile"
#compile
vlog +acc=rn -work $vlib_dir/work -f $file_list_dir/src_files.f

echo "start execute"
#execute
#console mode
vsim -c $vlib_dir/work.testbench -sv_lib $vlib_dir/SumClass -t ns -do "run -all"
#gui mode
#vsim $vlib_dir/work.testbench -sv_lib $vlib_dir/SumClass -t ns -do "set NoQuitOnFinish 1" -do wave.do
#-do "run -all"