module rom
import fetch_pkg::*;
#(
  parameter WORD_WIDTH=4,
  parameter ADDR_WIDTH=4,
  localparam ADDR_BITS=$clog2(ADDR_WIDTH)
) (
  input  logic                         clk,
  input  logic                         arstn,

  input  logic [ADDR_BITS-1 : 0]       addr_i,
  output logic [WORD_WIDTH-1 : 0]      data_o
);
  
  typedef logic [WORD_WIDTH-1 : 0] mem_array_t [ADDR_WIDTH-1 : 0];
  mem_array_t mem_array;

  instruction_t ins_tmp;

  initial begin
    ins_tmp.opcode = mov;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(0);
    ins_tmp.reg_dst = reg_t'(0);
    ins_tmp.imm = imm_t'(5);
    mem_array[0] = ins_tmp;

    ins_tmp.opcode = mov;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(0);
    ins_tmp.reg_dst = reg_t'(1);
    ins_tmp.imm = imm_t'(6);
    mem_array[1] = ins_tmp;

    ins_tmp.opcode = add;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(1);
    ins_tmp.reg_dst = reg_t'(1);
    ins_tmp.imm = imm_t'(0);
    mem_array[2] = ins_tmp;

    ins_tmp.opcode = mov;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(0);
    ins_tmp.reg_dst = reg_t'(2);
    ins_tmp.imm = imm_t'(7);
    mem_array[3] = ins_tmp;

    ins_tmp.opcode = add;
    ins_tmp.reg_s1 = reg_t'(1);
    ins_tmp.reg_s2 = reg_t'(2);
    ins_tmp.reg_dst = reg_t'(3);
    ins_tmp.imm = imm_t'(0);
    mem_array[4] = ins_tmp;

    ins_tmp.opcode = mov;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(0);
    ins_tmp.reg_dst = reg_t'(3);
    ins_tmp.imm = imm_t'(8);
    mem_array[5] = ins_tmp;

    ins_tmp.opcode = nop;
    ins_tmp.reg_s1 = reg_t'(0);
    ins_tmp.reg_s2 = reg_t'(0);
    ins_tmp.reg_dst = reg_t'(0);
    ins_tmp.imm = imm_t'(0);
    mem_array[6] = ins_tmp;
    //mem_array[3] = {WORD_WIDTH{1'b0}};
  end

  assign data_o = mem_array [addr_i];

endmodule