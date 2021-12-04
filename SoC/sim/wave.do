onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Top_test/u_Top_soc/clk_i
add wave -noupdate /Top_test/u_Top_soc/arstn_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /Top_test/u_Top_soc/wr_i
add wave -noupdate /Top_test/u_Top_soc/ack_wr_o
add wave -noupdate /Top_test/u_Top_soc/wr_data_i
add wave -noupdate /Top_test/u_Top_soc/wr_index_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /Top_test/u_Top_soc/rd_i
add wave -noupdate /Top_test/u_Top_soc/ack_rd_o
add wave -noupdate /Top_test/u_Top_soc/rd_data_o
add wave -noupdate /Top_test/u_Top_soc/rd_index_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /Top_test/u_Top_soc/u_ram/pedro
add wave -noupdate -expand /Top_test/u_Top_soc/u_ram/mem_array
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {0 ns} {184 ns}
