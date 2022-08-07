module reg_unit
  import fetch_pkg::*;
  import decoder_pkg::*;
  import reg_pkg::*;
#(
  
) (
  input  logic                         clk,
  input  logic                         arstn,

  //..read ctrl
  input reg_state_t reg_state_i,

  //..READ REG
  output imm_t      data_out1_o,
  input  reg_t      addr_out1_i,
  output imm_t      data_out2_o,
  input  reg_t      addr_out2_i,

  //..further signals
  input reg_fur_sig_t reg_fur_sig_i,
  output reg_fur_sig_t reg_fur_sig_o,

  //..WB REG
  input  logic      valid_in_i,
  input  imm_t      data_in_i,
  input  reg_t      addr_in_i
);

  //register bank
  typedef imm_t reg_bank_t [REG_NUM-1 : 0];

  reg_bank_t reg_bank_d;
  reg_bank_t reg_bank_q;

  //..ff reg
  reg_t addr_out1_d, addr_out1_q;
  reg_t addr_out2_d, addr_out2_q;
  assign addr_out1_d = (reg_state_i == reg_next)? addr_out1_i : addr_out1_q;
  assign addr_out2_d = (reg_state_i == reg_next)? addr_out2_i : addr_out2_q;

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
  assign data_out1_o = reg_bank_q[addr_out1_q];
  assign data_out2_o = reg_bank_q[addr_out2_q];


  //..ff wb
  always_comb begin
    reg_bank_d = reg_bank_q;
    if(valid_in_i) begin
      reg_bank_d[addr_in_i] = data_in_i;
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

  assign reg_fur_sig_d.alu_s1_font = reg_fur_sig_i.alu_s1_font;
  assign reg_fur_sig_d.alu_opcode = (reg_state_i == reg_next)? reg_fur_sig_i.alu_opcode : op_none;
  assign reg_fur_sig_d.wb_wr = (reg_state_i == reg_next)? reg_fur_sig_i.wb_wr : logic'(0);
  assign reg_fur_sig_d.reg_dst = reg_fur_sig_i.reg_dst;
  assign reg_fur_sig_d.imm = reg_fur_sig_i.imm;

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      reg_fur_sig_q.alu_s1_font <= alu_s1_font_t'(0);
      reg_fur_sig_q.alu_opcode <= op_none;
      reg_fur_sig_q.wb_wr <= logic'(0);
      reg_fur_sig_q.reg_dst <= reg_t'(0);
      reg_fur_sig_q.imm <= imm_t'(0);
    end else begin
      reg_fur_sig_q <= reg_fur_sig_d;
    end
  end

  //..reg vypas
  assign reg_fur_sig_o = reg_fur_sig_q;

endmodule
