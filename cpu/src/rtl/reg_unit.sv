module reg_unit
  import fetch_pkg::*;
  import decoder_pkg::*;
  import reg_pkg::*;
#(
  
) (
  input  logic                          clk,
  input  logic                          arstn,

  //..decoder_to_reg
  input  decoder_to_reg_req_t            decoder_to_reg_req_i,
  output reg_to_alu_info_t              reg_to_alu_info_o,

  //..wb_to_reg
  input wb_to_reg_req_t                 wb_to_reg_req_i,
  output wb_info_t                      wb_info_o
);

  //register bank
  reg_bank_t reg_bank_d;
  reg_bank_t reg_bank_q;

  //..ff reg
  reg_t addr_out1_d, addr_out1_q;
  reg_t addr_out2_d, addr_out2_q;
  assign addr_out1_d = (decoder_to_reg_req_i.state == reg_next)? decoder_to_reg_req_i.addr_out1 : addr_out1_q;
  assign addr_out2_d = (decoder_to_reg_req_i.state == reg_next)? decoder_to_reg_req_i.addr_out2 : addr_out2_q;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      addr_out1_q <= reg_t'(0);
      addr_out2_q <= reg_t'(0);
    end else begin
      addr_out1_q <= addr_out1_d;
      addr_out2_q <= addr_out2_d;
    end
  end

  //..reg read
  assign wb_to_reg_req_i.data_out1 = reg_bank_q[addr_out1_q];
  assign wb_to_reg_req_i.data_out2 = reg_bank_q[addr_out2_q];



  //..ff wb
  always_comb begin
    reg_bank_d = reg_bank_q;
    if(wb_to_reg_req_i.valid_in) begin
      reg_bank_d[addr_in_i] = wb_to_reg_req_i.data_in;
    end
  end

  always_ff @(posedge clk or negedge arstn) begin
    if(~arstn) begin
      reg_bank_q <= reg_bank_t'(0);
    end else begin
      reg_bank_q <= reg_bank_d;
    end
  end



  //..ff reg further signals
  reg_fur_sig_t reg_fur_sig_d, reg_fur_sig_q;

  assign reg_fur_sig_d.alu_s1_font  =                                              decoder_to_reg_req_i.fur_sig.alu_s1_font;
  assign reg_fur_sig_d.alu_opcode   =  (decoder_to_reg_req_i.state == reg_next)?   decoder_to_reg_req_i.fur_sig.alu_opcode    : op_none;
  assign reg_fur_sig_d.wb_wr        =  (decoder_to_reg_req_i.state == reg_next)?   decoder_to_reg_req_i.fur_sig.wb_wr         : logic'(0);
  assign reg_fur_sig_d.reg_dst      =                                              decoder_to_reg_req_i.fur_sig.reg_dst;
  assign reg_fur_sig_d.imm          =                                              decoder_to_reg_req_i.fur_sig.imm;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      reg_fur_sig_q.alu_s1_font  <= alu_s1_font_t'(0);
      reg_fur_sig_q.alu_opcode   <= op_none;
      reg_fur_sig_q.wb_wr        <= logic'(0);
      reg_fur_sig_q.reg_dst      <= reg_t'(0);
      reg_fur_sig_q.imm          <= imm_t'(0);
    end else begin
      reg_fur_sig_q              <= reg_fur_sig_d;
    end
  end
  
  assign reg_fur_sig_o = reg_fur_sig_q;
  //..end ff reg further signals



  //..ff wb further signals
  wb_fur_sig_t wb_fur_sig_d, wb_fur_sig_q;

  assign wb_fur_sig_d = wb_to_reg_req_i.fur_sig;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      wb_fur_sig_q.pc_branch <= logic'(0);
    end else begin
      wb_fur_sig_q <= wb_fur_sig_d; 
    end
  end

  assign wb_info_o.fur_sig = wb_fur_sig_q;
  //..end ff wb further signals

endmodule
