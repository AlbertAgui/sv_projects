
typedef enum logic { 
  read = 0,
  write = 1
} opcode_mem;

typedef enum logic [6 : 0] {
  LOAD = 0000011,
  STORE = 0100011,
  OP = 0110011
} opcode_RV32I;

typedef enum logic [14 : 12] {
  LW = 010,
  SW = 010,
  ADD = 000
} f3_RV32I;

typedef enum logic [31 : 25] {
  LOAD = 0000011,
  STORE = 0100011,
  ZERO = 0000000
} f7_RV32I;

typedef struct packed {
  logic [31:25] f7;
  logic [24:20] rs2;
  logic [19:15] rs1;
  logic [14:12] f3;
  logic [11:7] rd;
  logic [6:0] opcode;
} rtype_t;
