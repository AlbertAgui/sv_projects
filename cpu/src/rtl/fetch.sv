module fetch
import fetch_pkg::*;
#(
) (
  //..clk and arstn
  input   logic                  clk,
  input   logic                  arstn,

  //..fetch - decode
  input   fetch_state_t          fetch_state_i,
  output  instruction_t          fetch_inst_o,

  //..debug
  output  pc_t                   fetch_id_o
);

  //..ff pc fetch or keep instruction
  pc_t pc_d, pc_q;

  always_comb begin
    unique case (fetch_state_i)
      fetch_keep: begin
        pc_d = pc_q;
      end
      fetch_next: begin
        pc_d = (pc_q == (PC_NUM-1)) ? pc_t'(0) : pc_q + pc_t'(1);
      end
    endcase
  end

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      pc_q <= pc_t'(0);
    end else begin
      pc_q <= pc_d;
    end
  end

  //..instruction
  //..rom
  instruction_t raw_rom_instruction, rom_instruction;

  rom #(
    .WORD_WIDTH       (INS_SIZE),
    .ADDR_WIDTH       (PC_NUM)
  )
  rom_u
  (
    .clk(clk),
    .arstn(arstn),
    .addr_i(pc_q),
    .data_o(raw_rom_instruction)
  );
  assign rom_instruction = (~arstn) ? instruction_t'(0) : raw_rom_instruction;

  //..fetch or keep instruction
  assign fetch_inst_o = rom_instruction;

  //..debug
  assign fetch_id_o = pc_q;
endmodule
