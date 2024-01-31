module top_cpu
import decoder_pkg::*;
import fetch_pkg::*;
import alu_pkg::*;
import reg_pkg::*;
#(
) (
  input clk,
  input arstn
);
  
  //..debug
  pc_t fetch_id_d, fetch_id_q;
  pc_t decoder_id_d, decoder_id_q;
  pc_t reg_id_d, reg_id_q;
  pc_t alu_id_d, alu_id_q;
  pc_t wb_id_d, wb_id_q;

  //..fetch
  //..fetch - decode
  fetch_state_t fetch_state;
  instruction_t fetch_instruction;

  //..ff fetch
  /*always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      fetch_id_q <= pc_t'(0);
    end else begin
      fetch_id_q <= fetch_id_d;
    end
  end*/

  //..wb
  imm_t reg_data_dst;

  //..alu
  alu_fur_sig_t alu_in_fur_sig, alu_out_fur_sig;

  fetch #(
  ) fetch_u (
    //..clk and arstn
    .clk(clk),
    .arstn(arstn),

    //..fetch ctrl
    .fetch_state_i(fetch_state),
    //..fetch to decode
    .fetch_inst_o(fetch_instruction),

    //..alu to wb
    .pc_branch_i(alu_out_fur_sig.pc_branch),
    .pc_value_i(reg_data_dst),

    //..debug
    .fetch_id_o(fetch_id_q)
  );
  //..end fetch




  //..decode
  //..fetch to decode
  decode_state_t decode_state; 
  instruction_t decode_ins;
  assign decode_ins = fetch_instruction;

  //..decode to reg
  decoded_t decoded_ins;

  //..debug
  always_comb begin
    case (decode_state)
      decoder_keep: begin
        decoder_id_d = decoder_id_q;
      end
      decoder_next: begin
        decoder_id_d = fetch_id_q;
      end
    endcase
  end
  //assign decoder_id_d = fetch_id_q;

  //..ff fetch
  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      decoder_id_q <= pc_t'(0);
    end else begin
      decoder_id_q <= decoder_id_d;
    end
  end

  decoder  #(
  ) decoder_u (
    //..clk and arstn
    .clk(clk),
    .arstn(arstn),

    //..decode ctrl
    .decode_state_i(decode_state),
    //..fetch to decode
    .decode_inst_i(decode_ins),

    //..decode to reg
    .decoded_info_o(decoded_ins)
  );
  //..end decode



  //..reg
  reg_state_t reg_state;
  imm_t reg_data_src_1, reg_data_src_2;

  //..debug
  assign reg_id_d = (reg_state == reg_next)? decoder_id_q : pc_t'(0);
  
  //..ff reg
  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      reg_id_q <= pc_t'(0);
    end else begin
      reg_id_q <= reg_id_d;
    end
  end

  //..ff further signals
  reg_fur_sig_t reg_in_fur_sig, reg_out_fur_sig;
  assign reg_in_fur_sig.alu_s1_font = decoded_ins.alu_s1_font;
  assign reg_in_fur_sig.alu_opcode = decoded_ins.alu_opcode;
  assign reg_in_fur_sig.wb_wr = decoded_ins.wb_wr;
  assign reg_in_fur_sig.reg_dst = decoded_ins.reg_dst;
  assign reg_in_fur_sig.imm = decoded_ins.imm;
  //..end reg


  //..WB REG
  //..debug
  assign wb_id_d = alu_id_q;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      wb_id_q <= pc_t'(0);
    end else begin
      wb_id_q <= wb_id_d;
    end
  end
  

  wb_fur_sig_t wb_in_fur_sig, wb_out_fur_sig;
  assign wb_in_fur_sig.pc_branch = alu_out_fur_sig.pc_branch;

  //..reg bank body
  reg_unit #(
  ) reg_unit_u (
    .clk(clk),
    .arstn(arstn),

    //..READ REG
    //..read ctrl
    .reg_state_i(reg_state),
    .data_out1_o(reg_data_src_1),
    .addr_out1_i(decoded_ins.reg_s1),
    .data_out2_o(reg_data_src_2),
    .addr_out2_i(decoded_ins.reg_s2),
    //..further signals
    .reg_fur_sig_i(reg_in_fur_sig),
    .reg_fur_sig_o(reg_out_fur_sig),

    //..WB REG
    .valid_in_i(alu_out_fur_sig.wb_wr),
    .data_in_i(reg_data_dst),
    .addr_in_i(alu_out_fur_sig.reg_dst),
    //..further signals
    .wb_fur_sig_i(wb_in_fur_sig),
    .wb_fur_sig_o(wb_out_fur_sig)

  );
  //..end reg bank body



  //..alu
  assign alu_in_fur_sig.wb_wr = reg_out_fur_sig.wb_wr;
  assign alu_in_fur_sig.reg_dst = reg_out_fur_sig.reg_dst;

  //..debug
  assign alu_id_d = reg_id_q;

  //..ff alu
  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      alu_id_q <= pc_t'(0);
    end else begin
      alu_id_q <= alu_id_d;
    end
  end


  alu #(
  ) alu_u (
    //..clk and arstn
    .clk(clk),
    .arstn(arstn),

    //..alu ctrl
    .alu_s1_font_i(reg_out_fur_sig.alu_s1_font),
    .alu_opcode_i(reg_out_fur_sig.alu_opcode),
    .src_1_i(reg_data_src_1),
    .src_2_i(reg_data_src_2),
    .src_3_i(reg_out_fur_sig.imm),

    //..further signals
    .alu_fur_sig_i(alu_in_fur_sig),
    .alu_fur_sig_o(alu_out_fur_sig),

    //..output value
    .dst_o(reg_data_dst)
  );
  //..end alu




  //..Control
  logic reg_conflict, branch_conflict;

  ctrl_conflict #(
  ) reg_conflict_u (
    //..arstn
    .arstn(arstn),

    //..reg dependence conflict in
    //..old instruction - reg state
    .reg_opcode_i(reg_out_fur_sig.alu_opcode),
    .reg_dst_i(reg_out_fur_sig.reg_dst),
    //..new instruction - decode state
    .decode_opcode_i(decoded_ins.alu_opcode),
    .reg_src1_i(decoded_ins.reg_s1),
    .reg_src2_i(decoded_ins.reg_s2),

    //..branch conflict in
    .state_reg_pc_branch_i(reg_out_fur_sig.pc_branch),
    .state_alu_pc_branch_i(alu_out_fur_sig.pc_branch),
    .state_wb_pc_branch_i(wb_out_fur_sig.pc_branch),

    //..reg dependence conflict
    .reg_conflict_o(reg_conflict),

    //..branch conflict out
    .branch_conflict_o(branch_conflict)
  );

  always_comb begin
    fetch_state  = fetch_next;
    decode_state = decoder_next;
    reg_state = reg_next; 
    if(reg_conflict) begin
      fetch_state  = fetch_keep;
      decode_state = decoder_keep;
    end
    //if(reg_conflict || branch_conflict) begin
    if(reg_conflict) begin
      reg_state = reg_nope;
    end
  end

endmodule
