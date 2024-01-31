onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/clk
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/arstn
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/fetch_state_i
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/fetch_inst_o
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/pc_branch_i
add wave -noupdate -expand -group fetch -radix decimal /testbench/top_cpu_u/fetch_u/pc_value_i
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/fetch_id_o
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/pc_q
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/raw_rom_instruction
add wave -noupdate -expand -group fetch /testbench/top_cpu_u/fetch_u/rom_instruction
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/arstn
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/clk
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/decode_state_i
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/decode_inst_i
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/decoded_info_o
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/decode_inst_q
add wave -noupdate -group decode /testbench/top_cpu_u/decoder_u/decoded_info
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/clk
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/arstn
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_s1_font_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_opcode_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_1_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_2_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_3_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_fur_sig_i
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_fur_sig_o
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/dst_o
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_s1_font_q
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_opcode_q
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_1_q
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_2_q
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/src_3_q
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/operand_1
add wave -noupdate -group alu /testbench/top_cpu_u/alu_u/alu_fur_sig_q
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/clk
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/arstn
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/reg_state_i
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/data_out1_o
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/addr_out1_i
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/data_out2_o
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/addr_out2_i
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/reg_fur_sig_i
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/reg_fur_sig_o
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/addr_out1_q
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/addr_out2_q
add wave -noupdate -group reg /testbench/top_cpu_u/reg_unit_u/reg_bank_q
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/arstn
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/reg_opcode_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/reg_dst_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/decode_opcode_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/reg_src1_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/reg_src2_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/state_reg_pc_branch_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/state_alu_pc_branch_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/state_wb_pc_branch_i
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/reg_conflict_o
add wave -noupdate -group reg_conflict /testbench/top_cpu_u/reg_conflict_u/branch_conflict_o
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/clk
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/arstn
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/reg_state_i
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/valid_in_i
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/data_in_i
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/addr_in_i
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/wb_fur_sig_i
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/wb_fur_sig_o
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/reg_fur_sig_q
add wave -noupdate -group wb /testbench/top_cpu_u/reg_unit_u/wb_fur_sig_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {420 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 414
configure wave -valuecolwidth 117
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
WaveRestoreZoom {0 ns} {2040 ns}
