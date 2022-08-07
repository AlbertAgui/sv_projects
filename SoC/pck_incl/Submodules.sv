`include "RISCV_pkg.sv"
//fields
function opcode_t dec_opcode_f(
  input logic [31 : 0] inst
);
  return inst[6 : 0];
endfunction

function opcode_t dec_rd_f(
  input logic [31 : 0] inst
);
  return inst [11 : 7];
endfunction

function opcode_t dec_func3_f(
  input logic [31 : 0] inst
);
  return inst [14 : 12];
endfunction

function opcode_t dec_rs1_f(
  input logic [31 : 0] inst
);
  return inst [19 : 15];
endfunction

function opcode_t dec_rs2_f(
  input logic [31 : 0] inst
);
  return inst [24 : 20];
endfunction

function opcode_t dec_func7_f(
  input logic [31 : 0] inst
);
  return inst [31 : 25];
endfunction

//immed
function immed_t dec_Iimmed_f(
  input logic [31 : 0] inst;
);
  return {21{inst[31]}, inst[30 : 25], inst[24 : 21], inst[20]};
endfunction

function immed_t dec_Simmed_f(
  input logic [31 : 0] inst;
);
  return {21{inst[31]}, inst[30 : 25], inst[11 : 8], inst[7]};
endfunction

function immed_t dec_Bimmed_f(
  input logic [31 : 0] inst;
);
  return {20{inst[31]}, inst[7], inst[30 : 25], inst[11 : 8], 1'b0};
endfunction

function immed_t dec_Uimmed_f(
  input logic [31 : 0] inst;
);
  return {inst[31], inst[30 : 20], inst[19 : 12], {12{1'b0}}};
endfunction

function immed_t dec_Jimmed_f(
  input logic [31 : 0] inst;
);
  return {12{inst[31]}, inst[19 : 12], inst[20], inst[30 : 25], inst[24 : 21], 1'b0};
endfunction

function immed_t dec_0immed_f(
  input logic [31 : 0] inst;
);
  return {32{1'b0}};
endfunction