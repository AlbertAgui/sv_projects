module alu
import fetch_pkg::*;
import decoder_pkg::*;
import alu_pkg::*;
#(  
) (
  //..clk and arstn
  input logic clk,
  input logic arstn,

  //..reg_to_alu
  input  reg_to_alu_req_t reg_to_alu_req_i,
  output alu_to_wb_req_t  alu_to_wb_req_o

);

  //..ff alu
  alu_s1_font_t alu_s1_font_d, alu_s1_font_q;
  alu_opcode_t alu_opcode_d, alu_opcode_q;
  imm_t src_1_d, src_1_q;
  imm_t src_2_d, src_2_q;
  imm_t src_3_d, src_3_q;
  assign alu_s1_font_d   =  reg_to_alu_req_i.alu_s1_font;
  assign alu_opcode_d    =  reg_to_alu_req_i.alu_opcode;
  assign src_1_d         =  reg_to_alu_req_i.src_1;
  assign src_2_d         =  reg_to_alu_req_i.src_2;
  assign src_3_d         =  reg_to_alu_req_i.src_3;

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
        alu_to_wb_req_o.dst = imm_t'(0);
      end
      op_move: begin
        alu_to_wb_req_o.dst = operand_1;
      end
      op_add: begin
        alu_to_wb_req_o.dst = operand_1 + src_2_q;
      end
    endcase
  end



  //..ff alu further signals
  alu_fur_sig_t alu_fur_sig_d, alu_fur_sig_q;

  assign alu_fur_sig_d = reg_to_alu_req_i.fur_sig;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      alu_fur_sig_q.wb_wr <= logic'(0);
      alu_fur_sig_q.reg_dst <= reg_t'(0);
      alu_fur_sig_q.pc_branch <= logic'(0);
    end else begin
      alu_fur_sig_q <= alu_fur_sig_d; 
    end
  end

  //..alu vypas
  assign alu_to_wb_req_o.fur_sig = alu_fur_sig_q;

endmodule
