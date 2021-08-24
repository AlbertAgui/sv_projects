onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/cpu0/clk
add wave -noupdate /cpu_tb/cpu0/reset
add wave -noupdate /cpu_tb/cpu0/pc
add wave -noupdate /cpu_tb/cpu0/pipe_state
add wave -noupdate /cpu_tb/cpu0/pipe_state_temp
add wave -noupdate /cpu_tb/cpu0/MEM
add wave -noupdate /cpu_tb/cpu0/ins
add wave -noupdate -divider {New Divider}
add wave -noupdate /cpu_tb/cpu0/reg_or
add wave -noupdate /cpu_tb/cpu0/reg_dest
add wave -noupdate /cpu_tb/cpu0/op_code
add wave -noupdate /cpu_tb/cpu0/RegFile
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3 ns}
