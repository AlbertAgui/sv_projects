//fields
typedef logic [6 : 0]   opcode_t;
typedef logic [11 : 7]  rd_t;
typedef logic [14 : 12] funct3_t;
typedef logic [19 : 15] rs1_t;
typedef logic [24 : 20] rs2_t;
typedef logic [31 : 25] funct7_t;

//immed
typedef logic [31 : 0] immed_t;

//fields
typedef enum logic [6 : 0] {
  OP_IMM = 0010011,
  LUI = 0110111,
  AUIPC = 0010111,
  OP = 0110011,
  JAL = 1101111,
  JALR = 1100111,
  BRANCH = 1100011,
  LOAD = 0000011,
  STORE = 0100011
} opcode_RV32I;

typedef enum logic [14 : 12] {
  BEQ = 000,
  BNE = 001,
  BLT = 100,
  BGE = 101,
  BLTU = 110,
  BGEU = 111
} f3_BR_RV32I;

typedef enum logic [14 : 12] {
  JALR = 000
} f3_JMP_RV32I;

typedef enum logic [14 : 12] {
  LB = 000,
  LH = 001,
  LW = 010,
  LBU = 100,
  LHU = 101
} f3_LD_RV32I;

typedef enum logic [14 : 12] {
  SB = 000,
  SH = 001,
  SW = 010,
} f3_ST_RV32I;

typedef enum logic [14 : 12] {
  ADDI = 000,
  SLTI = 010,
  SLTIU = 011,
  XORI = 100,
  ORI = 110,
  ANDI = 111,
  SLLI = 001,
  SRLI = 101,
  SRAI = 101
} f3_OP_IMM_RV32I;

typedef enum logic [14 : 12] {
  ADD = 000,
  SUB = 000,
  SLL = 001,
  SLT = 010,
  SLTU = 011,
  XOR = 100,
  SRL = 101,
  SRA = 101,
  OR = 110,
  AND = 111
} f3_OP_RV32I;

typedef enum logic [31 : 25] {
  SLLI = 0000000,
  SRLI = 0000000,
  SRAI = 0100000
} f7_OP_IMM_RV32I;

typedef enum logic [31 : 25] {
  ADD = 0000000,
  SUB = 0100000,
  SLL = 0000000,
  SLT = 0000000,
  SLTU = 0000000,
  XOR = 0000000,
  SRL = 0000000,
  SRA = 0100000,
  OR = 0000000,
  AND = 0000000
} f7_RV32I;