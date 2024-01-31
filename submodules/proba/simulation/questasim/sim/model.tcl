set file_list_dir       ../file_list
set vlib_dir    ../workspace


#create library
vlib $vlib_dir/work


#add library
vmap $vlib_dir/work


#compile
vlog -sv +acc=rn -mfcu -suppress 2892,7033,7061 -work $vlib_dir/work -f $file_list_dir/test_sig.f 


#execute
vsim $vlib_dir/work.visible_tb -t ps -suppress 7033,7061  

do wave.do

run -all

quit
