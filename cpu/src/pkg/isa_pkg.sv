package isa_pkg begin
  localparam OPCODE_NUM = 3;
  localparam OPCODE_BITS = $clog2(OPCODE_NUM);

  localparam REG_NUM = 4;
  localparam REG_BITS = $clog2(REG_NUM);

  localparam IMM_BITS = 8;


  typedef logic[IMM_BITS-1:0] imm_t;

  typedef logic[REG_BITS-1:0] reg_t;

  typedef enum logic[OPCODE_BITS:0] {
    nop,
    add,
    mov,
    branch
  } opcode_t;

  typedef struct packed {
    opcode_t opcode;
    reg_t reg_s1;
    reg_t reg_s2;
    reg_t reg_dst;
    imm_t imm;
  } instruction_t;

  localparam PC_NUM = 11;
  localparam PC_BITS = $clog2(PC_NUM);
  typedef logic[PC_BITS-1:0] pc_t;

  localparam pc_t PC_INIT = pc_t'(0);
  localparam PC_ADDR_SIZE = 1;
  
end
