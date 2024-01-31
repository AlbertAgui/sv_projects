package alu_pkg;
  import isa_pkg::*;
  import decoder_pkg::*;

  typedef struct packed {
    logic valid;
    logic wb_wr;
    reg_t reg_dst;
    logic pc_branch;
  } alu_fur_sig_t;

  typedef struct packed {
    alu_opcode_t   alu_opcode;
    alu_s1_font_t  alu_s1_font;
    imm_t          src_1;
    imm_t          src_2;
    imm_t          src_3;
    alu_fur_sig_t  fur_sig;
  } reg_to_alu_req_t;
  
  typedef struct packed {
    imm_t          dst;
    alu_fur_sig_t  fur_sig;
  } alu_to_wb_req_t;

endpackage
