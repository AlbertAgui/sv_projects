package cpu_package;

///////////////////
//Size parameters
parameter ADDR_WIDTH=3, OPCODE_WIDTH=2, WORD_WIDTH=8;

/////////////////
//machine state//
/////////////////
typedef enum {
  StFetch,
  StDec,
  StExec
} Type_pipeline_state;

typedef enum logic [OPCODE_WIDTH-1:0] {
  op_write = 0,
  op_read = 1
} ReqOpcodeType;

endpackage;
