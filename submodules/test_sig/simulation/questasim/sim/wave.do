onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /test_sig_tb/count
add wave -noupdate /test_sig_tb/clk
add wave -noupdate /test_sig_tb/arst_n
add wave -noupdate -divider req
add wave -noupdate /test_sig_tb/u_smu/req_valid_i
add wave -noupdate /test_sig_tb/u_smu/req_grant_o
add wave -noupdate /test_sig_tb/u_smu/req_params_i
add wave -noupdate -divider state
add wave -noupdate /test_sig_tb/u_smu/state_q
add wave -noupdate -divider lane
add wave -noupdate /test_sig_tb/u_smu/lane_grant_o
add wave -noupdate /test_sig_tb/u_smu/lane_valid_i
add wave -noupdate /test_sig_tb/u_smu/lane_data_i
add wave -noupdate -divider vectors
add wave -noupdate -expand /test_sig_tb/u_smu/data_vec
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 306
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
WaveRestoreZoom {5 ps} {25 ps}
