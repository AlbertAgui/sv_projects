onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /visible_tb/visible_top_u/visible_u/a
add wave -noupdate /visible_tb/visible_top_u/visible_u/b
add wave -noupdate /visible_tb/visible_top_u/visible_u/c
add wave -noupdate /visible_tb/visible_top_u/a
add wave -noupdate /visible_tb/visible_top_u/b
add wave -noupdate /visible_tb/visible_top_u/c
add wave -noupdate /visible_tb/a
add wave -noupdate /visible_tb/b
add wave -noupdate /visible_tb/c
add wave -noupdate -expand /visible_tb/visible_top_u/visible_u/c_a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 365
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
WaveRestoreZoom {0 ps} {16 ps}
