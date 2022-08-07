module decoder_ctrl
  `include "Submodules.sv"
  `include "RISCV_pkg.sv"
#(
  parameter WORD_WIDTH=4,
  parameter ADDR_WIDTH=4
) (
  input logic [31 : 0] inst;

  output immed_t immed;

);

  always_comb begin
    case (variable)
      
      default: begin
        default_case
      end
    endcase
  end
  
endmodule
