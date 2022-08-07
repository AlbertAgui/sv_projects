module decoder
`include "Submodules.sv"
`include "RISCV_pkg.sv"
#(
  
) (
  input logic [31 : 0] inst_i;

  output opcode_t opcode_o;
  output funct3_t funct3_o;
  output funct7_t funct7_o;

  //regfile
  output rs1_t rs1_o;
  output logic dec_to_reg_rd1_o;
  output rs2_t rs2_o;
  output logic dec_to_reg_rd2_o;

  output logic dec_to_reg_wr_o;
  output rd_t rd_o;

  //alu
  output immed_t immed_o;
  output 
);
  
  decoder_fields #(
    
  ) u_decoder_fields(
    .inst_i (inst_i)


  );
    
  decoder_ctrl #(

  ) u_decoder_ctrl(
      .inst_i (inst_i)

  );

endmodule