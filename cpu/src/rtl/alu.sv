module alu
import fetch_pkg::*;
import decoder_pkg::*;
import alu_pkg::*;
#(  
) (
  //..clk and arstn
  input logic clk,
  input logic arstn,

  //..alu ctrl
  input alu_s1_font_t alu_s1_font_i,
  input alu_opcode_t alu_opcode_i,
  input imm_t src_1_i,
  input imm_t src_2_i,
  input imm_t src_3_i,

  //..further signals
  input logic wb_wr_i,
  input reg_t reg_dst_i,
  output logic wb_wr_o,
  output reg_t reg_dst_o,

  //..output value
  output imm_t dst_o
);

  //..ff alu
  alu_s1_font_t alu_s1_font_d, alu_s1_font_q;
  alu_opcode_t alu_opcode_d, alu_opcode_q;
  imm_t src_1_d, src_1_q;
  imm_t src_2_d, src_2_q;
  imm_t src_3_d, src_3_q;
  assign alu_s1_font_d = alu_s1_font_i;
  assign alu_opcode_d = alu_opcode_i;
  assign src_1_d = src_1_i;
  assign src_2_d = src_2_i;
  assign src_3_d = src_3_i;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      alu_s1_font_q <= alu_s1_font_t'(0);
      alu_opcode_q <= alu_opcode_t'(0);
      src_1_q <= imm_t'(0);
      src_2_q <= imm_t'(0);
      src_3_q <= imm_t'(0);
    end else begin
      alu_s1_font_q <= alu_s1_font_d;
      alu_opcode_q <= alu_opcode_d;
      src_1_q <= src_1_d;
      src_2_q <= src_2_d;
      src_3_q <= src_3_d;
    end
  end


  imm_t operand_1;
  always_comb begin
    case (alu_s1_font_q)
      font_reg: begin
        operand_1 = src_1_q;
      end
      font_imm: begin
        operand_1 = src_3_q;
      end
    endcase
  end

  always_comb begin
    case (alu_opcode_q)
      op_none: begin
        dst_o = imm_t'(0);
      end
      op_move: begin
        dst_o = operand_1;
      end
      op_add: begin
        dst_o = operand_1 + src_2_q;
      end
    endcase
  end



  //..ff alu further signals
  logic wb_wr_d, wb_wr_q;
  reg_t reg_dst_d, reg_dst_q;

  assign wb_wr_d = wb_wr_i;
  assign reg_dst_d = reg_dst_i;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      wb_wr_q <= logic'(0);
      reg_dst_q <= reg_t'(0);
    end else begin
      wb_wr_q <= wb_wr_d;
      reg_dst_q <= reg_dst_d;
    end
  end

  //..alu vypas
  assign wb_wr_o = wb_wr_q;
  assign reg_dst_o = reg_dst_q;
endmodule