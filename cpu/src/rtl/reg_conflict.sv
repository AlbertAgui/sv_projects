module reg_conflict
import fetch_pkg::*;
import decoder_pkg::*;
#(
) (
  //..arstn
  input arstn,

  //..old instruction - reg state
  input alu_opcode_t reg_opcode_i,
  input reg_t reg_dst_i,

  //..new instruction - decode state
  input alu_opcode_t decode_opcode_i,
  input reg_t reg_src1_i,
  input reg_t reg_src2_i,

  //..reg dependence conflict
  output logic reg_conflict_o
);
  assign reg_conflict_o = ((reg_dst_i == reg_src1_i) || (reg_dst_i == reg_src2_i)) && (decode_opcode_i == op_add) && (reg_opcode_i != op_none);

endmodule
