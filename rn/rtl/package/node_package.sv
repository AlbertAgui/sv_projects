package node_package;

///////////////////
//Size parameters
parameter ADDR_WIDTH=3, OPCODE_WIDTH=1, WORD_WIDTH=8;

/////////////////
//Channel types//
/////////////////

/////////////////
//Req types

typedef enum logic [OPCODE_WIDTH-1:0] {
  op_write = 1'b0,
  op_read = 1'b1
} ReqOpcodeType;

typedef struct packed {
  ReqOpcodeType opcode;
  logic [ADDR_WIDTH-1:0] addr;
} ReqType;

/////////////
//Data types

typedef enum logic [OPCODE_WIDTH-1:0] {
  op_data_recv = 1'b0,
  op_no_data_recv = 1'b1
} DataOpcodeType;

typedef struct packed{
  DataOpcodeType opcode; 
  logic [ADDR_WIDTH-1:0] addr;
  logic [WORD_WIDTH-1:0] data;
} DataType;

/////////////
//Resp Types

typedef struct {
  logic [OPCODE_WIDTH-1:0] opcode;
} RespType;


/////////////////
//machine state//
/////////////////
typedef enum {
  StIdle,
  StAsserted,
  StData_Pass  
} Type_chn_state;


endpackage
