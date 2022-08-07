module decoder_fields
  `include "Submodules.sv"
  `include "RISCV_pkg.sv"
#(
  parameter WORD_WIDTH=4,
  parameter ADDR_WIDTH=4
) (
  input logic [31 : 0] inst_i;

  output opcode_t opcode_o;
  output rd_t rd_o;
  output funct3_t funct3_o;
  output rs1_t rs1_o;
  output rs2_t rs2_o;
  output funct7_t funct7_o;

  output immed_t immed_o;

);
  opcode_t opcode;

  opcode = dec_opcode_f(inst_i);
  rd_o = dec_rd_f(inst_i);
  funct3_o = dec_func3_f(inst_i);
  rs1_o = dec_rs1_f(inst_i);
  rs2_o = dec_rs1_f(inst_i);
  funct7_o = dec_func7_f(inst_i);

  always_comb begin
    case (opcode)
      LUI: begin
        immed_o = dec_Uimmed_f(inst_i);
      end
      AUIPC: begin
        immed_o = dec_Uimmed_f(inst_i);
      end
      OP_IMM: begin
        immed_o = dec_Iimmed_f(inst_i);
      end
      JAL: begin
        immed_o = dec_Jimmed_f(inst_i);
      end
      JALR: begin
        immed_o = dec_Iimmed_f(inst_i);
      end
      BRANCH: begin
        immed_o = dec_Bimmed_f(inst_i);
      end
      LOAD: begin
        immed_o = dec_Iimmed_f(inst_i);
      end
      STORE: begin
        immed_o = dec_Simmed_f(inst_i);
      end
      default: begin
        immed_o = dec_0immed_f(inst_i);
      end
    endcase
  end
  
endmodule