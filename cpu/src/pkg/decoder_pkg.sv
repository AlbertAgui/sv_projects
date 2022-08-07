package decoder_pkg;
  import fetch_pkg::*;
  localparam DECODE_STATE_NUM = 2;
  localparam DECODE_STATE_BITS = $clog2(DECODE_STATE_NUM);
  typedef enum logic[DECODE_STATE_BITS-1:0] { 
    decoder_keep,
    decoder_next
  } decode_state_t;


  //..decoder fields
  localparam ALU_S1_FONT_NUM = 2;
  localparam ALU_S1_FONT_BITS = $clog2(ALU_S1_FONT_NUM);
  typedef enum logic[ALU_S1_FONT_BITS-1:0] {  
    font_reg,
    font_imm
  } alu_s1_font_t;

  localparam ALU_OPCODE_NUM = 3;
  localparam ALU_OPCODE_BITS = $clog2(ALU_OPCODE_NUM);
  typedef enum logic[ALU_OPCODE_BITS-1:0] {  
    op_none,
    op_move,
    op_add
  } alu_opcode_t;

  typedef struct packed {
    alu_s1_font_t alu_s1_font;
    alu_opcode_t alu_opcode;
    logic wb_wr;
    reg_t reg_s1;
    reg_t reg_s2;
    reg_t reg_dst;
    imm_t imm;
  } decoded_t;
  //..end decoder fields

endpackage
