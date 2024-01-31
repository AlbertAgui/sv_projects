package reg_pkg;
  import isa_pkg::*;
  import decoder_pkg::*;

  typedef imm_t reg_bank_t [REG_NUM-1 : 0];

  //..decoder_to_reg
  localparam REG_STATE_NUM = 2;
  localparam REG_STATE_BITS = $clog2(REG_STATE_NUM);
  typedef enum logic[REG_STATE_BITS-1:0] {
    reg_nope,
    reg_next
  } reg_state_t;

  typedef struct packed {
    logic            valid;
    alu_s1_font_t    alu_s1_font;
    alu_opcode_t     alu_opcode;
    logic            wb_wr;
    reg_t            reg_dst;
    imm_t            imm;
    logic            pc_branch;
  } reg_fur_sig_t;

  typedef struct packed {
    reg_state_t    state;
    reg_t          addr_out1;
    reg_t          addr_out2;
    reg_fur_sig_t  fur_sig;
  } decoder_to_reg_req_t;

  typedef struct packed {
    imm_t         data_out1;
    imm_t         data_out2;
    reg_fur_sig_t fur_sig;
  } reg_to_alu_info_t;
  //..end decoder_to_reg


  //..wb_to_reg
  typedef struct packed {
    logic valid;
    logic pc_branch;
  } wb_fur_sig_t;

  typedef struct packed {
    logic              valid_in;
    imm_t              data_in;
    reg_t              addr_in;
    wb_fur_sig_t       fur_sig;
  } wb_to_reg_req_t;

  typedef struct packed {
    wb_fur_sig_t fur_sig;
  } wb_info_t;
  //..end wb_to_reg

endpackage
