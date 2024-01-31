module fetch
  import fetch_pkg::*;
#(
) (
  //..clk and arstn
  input   logic                        clk,
  input   logic                        arstn,

  //..fetch
  input   fetch_req_t                  fetch_req_i,
  output  fetch_to_decoder_info_t      fetch_to_decoder_info_o, 

  //..wb_to_fetch
  input   wb_to_fetch_req_t            wb_to_fetch_req_i,          

  //..debug
  output  pc_t                         fetch_id_o
);

  //..pc
  pc_t pc_d, pc_q;
  logic take_branch;
  imm_t branch_value;

  assign take_branch  = wb_to_fetch_req_i.take_branch;
  assign branch_value        = wb_to_fetch_req_i.branch_value;

  always_comb begin
    unique case (fetch_state_i)
      fetch_nope: begin
        pc_d = PC_INIT;
      end
      fetch_keep: begin
        pc_d = pc_q;
      end
      fetch_next: begin
        pc_d = pc_q + ((take_branch) ? branch_value : pc_q + pc_t'(PC_ADDR_SIZE));
      end
    endcase
  end

  always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
      pc_q <= PC_INIT;
    end else begin
      pc_q <= pc_d;
    end
  end
  //..end pc


  //..instruction
  //..rom
  instruction_t rom_instruction;

  rom #(
    .WORD_WIDTH       (INS_SIZE),
    .ADDR_WIDTH       (PC_NUM)
  )
  rom_u
  (
    .clk(clk),
    .arstn(arstn),
    .addr_i(pc_q),
    .data_o(rom_instruction)
  );

  //..fetch or keep instruction
  assign fetch_to_decoder_info_o.valid = arstn;
  assign fetch_to_decoder_info_o.raw_instruction = (arstn) ? rom_instruction : instruction_t'(0);

  //..debug
  assign fetch_id_o = pc_q;
endmodule
