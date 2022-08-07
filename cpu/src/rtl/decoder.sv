module decoder
import fetch_pkg::*;
import decoder_pkg::*;
#(
  localparam ins_size = 4
  
) (
  //..arstn
  input logic arstn,
  input logic clk,

  //..fetch to decode
  input decode_state_t decode_state_i,
  input instruction_t decode_inst_i,

  //..decode to reg
  output decoded_t decoded_info_o
);

  //..ff decoder keep or next
  instruction_t decode_inst_d, decode_inst_q;

  always_comb begin
    unique case (decode_state_i)
      decoder_keep: begin
        decode_inst_d = decode_inst_q;
      end
      decoder_next: begin
        decode_inst_d = decode_inst_i;
      end
    endcase
  end

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      decode_inst_q <= instruction_t'(0);
    end else begin
      decode_inst_q <= decode_inst_d;
    end
  end

  //..decode info
  decoded_t decoded_info;

  always_comb begin
    decoded_info = decoded_t'(0);
    unique case (decode_inst_q.opcode)
      add: begin
        decoded_info.alu_s1_font = font_reg;
        decoded_info.alu_opcode = op_add;
        decoded_info.wb_wr = 1'b1;
      end
      mov: begin
        decoded_info.alu_s1_font = font_imm;
        decoded_info.alu_opcode = op_move;
        decoded_info.wb_wr = 1'b1;
      end
      nop: begin
        decoded_info.alu_opcode = op_none;
        decoded_info.wb_wr = 1'b0;
      end
    endcase
    decoded_info.reg_s1 = decode_inst_q.reg_s1;
    decoded_info.reg_s2 = decode_inst_q.reg_s2;
    decoded_info.reg_dst = decode_inst_q.reg_dst;
    decoded_info.imm = decode_inst_q.imm;
  end

  assign decoded_info_o = decoded_info;

endmodule
