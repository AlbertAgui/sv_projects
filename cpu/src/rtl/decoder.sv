module decoder
import fetch_pkg::*;
import decoder_pkg::*;
#(
  localparam ins_size = 4
  
) (
  //..arstn
  input logic arstn,
  input logic clk,

  //..fetch_to_decoder
  input  fetch_to_decoder_req_t fetch_to_decoder_req_i,
  output decoder_to_reg_info_t decoder_to_reg_info_o

);

  //..ff decoder keep or next
  fetch_to_decoder_req_t fetch_to_decoder_req_d, fetch_to_decoder_req_q;

  always_comb begin
    unique case (fetch_to_decoder_req_i.decoder_state)
      decoder_nope: begin
        fetch_to_decoder_req_d = fetch_to_decoder_req_t'(0);
      end
      decoder_keep: begin
        fetch_to_decoder_req_d = decode_inst_q;
      end
      decoder_next: begin
        fetch_to_decoder_req_d = decode_inst_i;
      end
    endcase
  end

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      fetch_to_decoder_req_q <= fetch_to_decoder_req_t'(0);
    end
      fetch_to_decoder_req_q <= fetch_to_decoder_req_d;
    end
  end

  //..decode info
  decoded_instruction_t decoded_instruction;

  always_comb begin
    decoded_instruction = decoded_t'(0);
    unique case (decoded_instruction_q.opcode)
      add: begin
        decoded_instruction.alu_s1_font = font_reg;
        decoded_instruction.alu_opcode = op_add;
        decoded_instruction.wb_wr = 1'b1;
      end
      mov: begin
        decoded_instruction.alu_s1_font = font_imm;
        decoded_instruction.alu_opcode = op_move;
        decoded_instruction.wb_wr = 1'b1;
      end
      nop: begin
        decoded_instruction.alu_opcode = op_none;
        decoded_instruction.wb_wr = 1'b0;
      end
      branch: begin
        decoded_instruction.alu_s1_font = font_reg;
        decoded_instruction.alu_opcode = op_add;
        decoded_instruction.wb_wr = 1'b0;
        decoded_instruction.pc_branch = 1'b1;
      end
    endcase
    decoded_instruction.reg_s1 = decoded_instruction_q.reg_s1;
    decoded_instruction.reg_s2 = decoded_instruction_q.reg_s2;
    decoded_instruction.reg_dst = decoded_instruction_q.reg_dst;
    decoded_instruction.imm = decoded_instruction_q.imm;
  end

  assign decoder_to_reg_info_o.decoded_instruction = decoded_instruction;
  assign decoder_to_reg_info_o.valid = (fetch_to_decoder_req_q.decoder_state != decoder_nope);

endmodule
