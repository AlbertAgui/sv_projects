onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/DATA_SIZE
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/DEPTH
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/B_DEPTH_CNT
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/B_DEPTH
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/clk_i
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/rstn_i
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/wr_valid_i
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/wr_ready_o
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/wr_data_i
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/rd_valid_o
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/rd_veady_i
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/rd_data_o
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/depth_cnt_q
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/queue
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/wr_pt_q
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/rd_pt_q
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/full
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/empty
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/write
add wave -noupdate -group req_queue /dut_top_tb/dut/req_queue/read
add wave -noupdate -group dut /dut_top_tb/dut/COUNT
add wave -noupdate -group dut /dut_top_tb/dut/DATA_SIZE
add wave -noupdate -group dut /dut_top_tb/dut/DEPTH
add wave -noupdate -group dut /dut_top_tb/dut/REQ_NUM_STATES
add wave -noupdate -group dut /dut_top_tb/dut/B_REQ_NUM_STATES
add wave -noupdate -group dut /dut_top_tb/dut/RESP_NUM_STATES
add wave -noupdate -group dut /dut_top_tb/dut/B_RESP_NUM_STATES
add wave -noupdate -group dut /dut_top_tb/dut/B_COUNT
add wave -noupdate -group dut /dut_top_tb/dut/RESP_RESOURCES
add wave -noupdate -group dut /dut_top_tb/dut/B_RESP_RESOURCES
add wave -noupdate -group dut /dut_top_tb/dut/clk_i
add wave -noupdate -group dut /dut_top_tb/dut/rstn_i
add wave -noupdate -group dut /dut_top_tb/dut/req_valid_i
add wave -noupdate -group dut /dut_top_tb/dut/req_data_i
add wave -noupdate -group dut /dut_top_tb/dut/req_ready_o
add wave -noupdate -group dut /dut_top_tb/dut/resp_valid_o
add wave -noupdate -group dut /dut_top_tb/dut/resp_data_o
add wave -noupdate -group dut /dut_top_tb/dut/req_state_q
add wave -noupdate -group dut /dut_top_tb/dut/resp_state_q
add wave -noupdate -group dut /dut_top_tb/dut/req_counter_q
add wave -noupdate -group dut /dut_top_tb/dut/resp_counter_q
add wave -noupdate -group dut /dut_top_tb/dut/req_queue_valid_q
add wave -noupdate -group dut /dut_top_tb/dut/req_queue_ready
add wave -noupdate -group dut /dut_top_tb/dut/resp_resources_q
add wave -noupdate -group dut /dut_top_tb/dut/resp_queue_ready_q
add wave -noupdate -group dut /dut_top_tb/dut/resp_queue_valid
add wave -noupdate -group dut /dut_top_tb/dut/req_set
add wave -noupdate -group dut /dut_top_tb/dut/req_unset
add wave -noupdate -group dut /dut_top_tb/dut/resp_set
add wave -noupdate -group dut /dut_top_tb/dut/resp_unset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30000 ps} 1} {{Cursor 2} {310000 ps} 1} {{Cursor 3} {211715 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 185
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {795296 ps}
