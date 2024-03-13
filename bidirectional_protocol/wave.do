onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group dut /testbench/dut/clk_i
add wave -noupdate -group dut /testbench/dut/rstn_i
add wave -noupdate -group dut /testbench/dut/req_valid_i
add wave -noupdate -group dut /testbench/dut/req_data_i
add wave -noupdate -group dut /testbench/dut/req_ready_o
add wave -noupdate -group dut /testbench/dut/resp_valid_o
add wave -noupdate -group dut /testbench/dut/resp_data_o
add wave -noupdate -group dut /testbench/dut/req_state_d
add wave -noupdate -group dut /testbench/dut/req_state_q
add wave -noupdate -group dut /testbench/dut/resp_state_q
add wave -noupdate -group dut /testbench/dut/req_counter_q
add wave -noupdate -group dut /testbench/dut/resp_counter_q
add wave -noupdate -group dut /testbench/dut/req_queue_valid_q
add wave -noupdate -group dut /testbench/dut/req_queue_ready
add wave -noupdate -group dut /testbench/dut/resp_resources_q
add wave -noupdate -group dut /testbench/dut/resp_queue_ready_q
add wave -noupdate -group dut /testbench/dut/resp_queue_valid
add wave -noupdate -group dut /testbench/dut/req_set
add wave -noupdate -group dut /testbench/dut/req_unset
add wave -noupdate -group dut /testbench/dut/resp_set
add wave -noupdate -group dut /testbench/dut/resp_unset
add wave -noupdate -group dut /testbench/dut/queue_wr
add wave -noupdate -expand -group req /testbench/dut/req_queue/clk_i
add wave -noupdate -expand -group req /testbench/dut/req_queue/rstn_i
add wave -noupdate -expand -group req /testbench/dut/req_queue/wr_valid_i
add wave -noupdate -expand -group req /testbench/dut/req_queue/wr_ready_o
add wave -noupdate -expand -group req /testbench/dut/req_queue/wr_data_i
add wave -noupdate -expand -group req /testbench/dut/req_queue/rd_valid_o
add wave -noupdate -expand -group req /testbench/dut/req_queue/rd_veady_i
add wave -noupdate -expand -group req /testbench/dut/req_queue/rd_data_o
add wave -noupdate -expand -group req /testbench/dut/req_queue/depth_cnt_q
add wave -noupdate -expand -group req /testbench/dut/req_queue/queue
add wave -noupdate -expand -group req /testbench/dut/req_queue/wr_pt_q
add wave -noupdate -expand -group req /testbench/dut/req_queue/rd_pt_q
add wave -noupdate -expand -group req /testbench/dut/req_queue/full
add wave -noupdate -expand -group req /testbench/dut/req_queue/empty
add wave -noupdate -expand -group req /testbench/dut/req_queue/write
add wave -noupdate -expand -group req /testbench/dut/req_queue/read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2349 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {454656 ps}
