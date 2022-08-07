typedef enum logic { 
  read = 0,
  write = 1
} opcode_mem;

parameter WORD_WIDTH=4;
parameter INDEX_WIDTH=4;
parameter OPCODE_MEM_WIDTH=1;