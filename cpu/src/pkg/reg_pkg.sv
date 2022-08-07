package reg_pkg;
  import decoder_pkg::*;
  import fetch_pkg::*;

  localparam REG_STATE_NUM = 2;
  localparam REG_STATE_BITS = $clog2(REG_STATE_NUM);
  typedef enum logic[REG_STATE_BITS-1:0] { 
    reg_nope,
    reg_next
  } reg_state_t;


  typedef struct packed {
    alu_s1_font_t alu_s1_font;
    alu_opcode_t alu_opcode;
    logic wb_wr;
    reg_t reg_dst;
    imm_t imm;
  } reg_fur_sig_t;

endpackage
