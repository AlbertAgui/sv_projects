onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /noc_tb/rn0/clk
add wave -noupdate /noc_tb/rn0/reset
add wave -noupdate /noc_tb/rn0/work
add wave -noupdate /noc_tb/rn0/pre_tx_req
add wave -noupdate -expand /noc_tb/rn0/tx_req
add wave -noupdate /noc_tb/rn0/v_tx_req
add wave -noupdate -expand /noc_tb/rn0/RegFile
add wave -noupdate /noc_tb/rn0/wr
add wave -noupdate /noc_tb/rn0/rx_data_buffer
add wave -noupdate /noc_tb/rn0/req_state_temp
add wave -noupdate /noc_tb/rn0/req_state
add wave -noupdate /noc_tb/rn0/data_state_temp
add wave -noupdate /noc_tb/rn0/data_state
add wave -noupdate -divider {New Divider}
add wave -noupdate /noc_tb/sn0/pre_tx_data
add wave -noupdate -expand /noc_tb/sn0/tx_data
add wave -noupdate /noc_tb/sn0/v_tx_data
add wave -noupdate -expand /noc_tb/sn0/RegFile
add wave -noupdate -expand /noc_tb/sn0/rx_req_buffer
add wave -noupdate /noc_tb/sn0/req_state_temp
add wave -noupdate /noc_tb/sn0/req_state
add wave -noupdate /noc_tb/sn0/data_state_temp
add wave -noupdate /noc_tb/sn0/data_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
WaveRestoreZoom {0 ns} {43 ns}
