package decoder_pkg;
  import isa_pkg::*;

  //..fetch_to_decoder
  localparam DECODE_STATE_NUM = 2;
  localparam DECODE_STATE_BITS = $clog2(DECODE_STATE_NUM);
  typedef enum logic[DECODE_STATE_BITS-1:0] { 
    decoder_nope,
    decoder_keep,
    decoder_next
  } decoder_state_t;

  localparam ALU_S1_FONT_NUM = 2;
  localparam ALU_S1_FONT_BITS = $clog2(ALU_S1_FONT_NUM);
  typedef enum logic[ALU_S1_FONT_BITS-1:0] {  
    font_reg,
    font_imm
  } alu_s1_font_t;

  localparam ALU_OPCODE_NUM = 3;
  localparam ALU_OPCODE_BITS = $clog2(ALU_OPCODE_NUM);
  typedef enum logic[ALU_OPCODE_BITS-1:0] {  
    alu_op_nope,
    alu_op_move,
    alu_op_add
  } alu_opcode_t;

  typedef struct packed {
    logic pc_branch;
    alu_s1_font_t alu_s1_font;
    alu_opcode_t alu_opcode;
    logic wb_wr;
    reg_t reg_s1;
    reg_t reg_s2;
    reg_t reg_dst;
    imm_t imm;
  } decoded_instruction_t;

  typedef struct packed {
    decoder_state_t state;
    instruction_t raw_instruction;
  } fetch_to_decoder_req_t;

  typedef struct packed {
    logic valid;
    decoded_instruction_t decoded_instruction;
  } decoder_to_reg_info_t;
  //..end fetch_to_decoder

endpackage
