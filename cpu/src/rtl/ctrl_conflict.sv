module ctrl_conflict
import fetch_pkg::*;
import decoder_pkg::*;
#(
) (
  //..arstn
  input arstn,

  //..reg dependence conflict in
  //..old instruction - reg state
  input alu_opcode_t reg_opcode_i,
  input reg_t reg_dst_i,
  //..new instruction - decode state
  input alu_opcode_t decode_opcode_i,
  input reg_t reg_src1_i,
  input reg_t reg_src2_i,

  //..branch conflict in
  input logic state_reg_pc_branch_i,
  input logic state_alu_pc_branch_i,
  input logic state_wb_pc_branch_i,

  //..reg dependence conflict out
  output logic reg_conflict_o,

  //..branch conflict out
  output logic branch_conflict_o
);
  assign reg_conflict_o = ((reg_dst_i == reg_src1_i) || (reg_dst_i == reg_src2_i)) && (decode_opcode_i == op_add) && (reg_opcode_i != op_none);
  assign branch_conflict_o = state_reg_pc_branch_i || state_alu_pc_branch_i || state_wb_pc_branch_i;
endmodule
