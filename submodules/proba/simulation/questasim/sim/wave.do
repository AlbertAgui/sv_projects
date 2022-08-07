onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mod_temp/u_temp/clk
add wave -noupdate /mod_temp/u_temp/arst_n
add wave -noupdate -divider {int in}
add wave -noupdate /mod_temp/u_temp/valid_q
add wave -noupdate -divider internal
add wave -noupdate /mod_temp/u_temp/wr
add wave -noupdate /mod_temp/u_temp/rd
add wave -noupdate /mod_temp/u_temp/cnt_q
add wave -noupdate /mod_temp/u_temp/wr_pt_q
add wave -noupdate /mod_temp/u_temp/buff
add wave -noupdate -divider {int out}
add wave -noupdate /mod_temp/u_temp/required_q
add wave -noupdate /mod_temp/u_temp/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 269
configure wave -valuecolwidth 123
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {46 ps}
