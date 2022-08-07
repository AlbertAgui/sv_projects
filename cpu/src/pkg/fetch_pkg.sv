package fetch_pkg;

  localparam PC_NUM = 7;
  localparam PC_BITS = $clog2(PC_NUM);
  typedef logic[PC_BITS-1:0] pc_t;

  localparam FETCH_STATE_NUM = 2;
  localparam FETCH_STATE_BITS = $clog2(FETCH_STATE_NUM);
  typedef enum logic[FETCH_STATE_BITS-1:0] { 
    fetch_keep,
    fetch_next
  } fetch_state_t;


  //..instruction fields
  localparam OPCODE_NUM = 3;
  localparam OPCODE_BITS = $clog2(OPCODE_NUM);
  typedef enum logic[OPCODE_BITS:0] {
    nop,
    add,
    mov
  } opcode_t;

  localparam REG_NUM = 4;
  localparam REG_BITS = $clog2(REG_NUM);
  typedef logic[REG_BITS-1:0] reg_t;

  localparam IMM_BITS = 8;
  typedef logic[IMM_BITS-1:0] imm_t;

  typedef struct packed {
    opcode_t opcode;
    reg_t reg_s1;
    reg_t reg_s2;
    reg_t reg_dst;
    imm_t imm;
  } instruction_t;
  localparam INS_SIZE = $bits(instruction_t);
  //..end instruction fields

endpackage
