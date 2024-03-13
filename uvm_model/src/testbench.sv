import uvm_pkg::*;
`include "uvm_macros.svh"

import uvm_test_pkg::*;

module testbench;
  clk_rst_if clrst_if();
  data_if data_a_if();
  data_if data_b_if();
  logic wr;

  //clk
  initial begin 
    clrst_if.clk = 1'b0;
    forever clrst_if.clk = #10 ~clrst_if.clk;
  end 

  //test
  initial begin
    clrst_if.rst_n = 0;
    repeat (1) @(posedge clrst_if.clk);
    clrst_if.rst_n = 1;
    repeat (1) @(posedge clrst_if.clk);
  end

  always_ff @(posedge clrst_if.clk or negedge clrst_if.rst_n) begin : proc_
    if(~clrst_if.rst_n) begin
       
    end else if (wr) begin
      $display("Access.");
       dut_top_u.sum_object_add(0,3);
    end
  end

  dut_top dut_top_u (
    .clk(clrst_if.clk),
    .rst_n(clrst_if.rst_n),

    .a_i(data_a_if.data),
    .b_i(data_b_if.data));

  initial begin
    uvm_config_db #(virtual data_if)::set(null,"*", "data_a_if", data_a_if);    
    uvm_config_db #(virtual data_if)::set(null,"*", "data_b_if", data_b_if);
    uvm_config_db #(virtual clk_rst_if)::set(null,"*", "clrst_if", clrst_if);
    /*if(!uvm_config_db #(logic)::get(this,"", "wr", wr))
      `uvm_error(get_type_name(), "wr not found")*/

    run_test();
  end

endmodule

