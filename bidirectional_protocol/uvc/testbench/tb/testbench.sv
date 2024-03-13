`ifndef TESTBENCH_SV
`define TESTBENCH_SV

import top_uvm_pkg::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

module testbench;
clk_rst_if clrst_if();
req_resp_if#(DATA_SIZE, CNFG) m_req_resp_if();

localparam TIMEOUT_CYCLES = 2000;

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

assign m_req_resp_if.clk = clrst_if.clk;
assign m_req_resp_if.rstn = clrst_if.rst_n;

dut_top #(
  .COUNT(COUNT),
  .CNFG(CNFG),
  .DATA_SIZE(DATA_SIZE),
  .DEPTH(DEPTH)
) dut (
  .clk_i(m_req_resp_if.clk),
  .rstn_i(m_req_resp_if.rstn),
  .req_valid_i(m_req_resp_if.req_valid),
  .req_data_i(m_req_resp_if.req_data),
  .req_ready_o(m_req_resp_if.req_ready),
  .resp_valid_o(m_req_resp_if.resp_valid),
  .resp_data_o(m_req_resp_if.resp_data)
);

initial begin
  uvm_config_db #(virtual req_resp_if#(DATA_SIZE, CNFG))::set(null,"*", "req_resp_if", m_req_resp_if);    

  run_test();
end

int unsigned cycles_wo_completed_q;

always_ff @(posedge clrst_if.clk or negedge clrst_if.rst_n) begin
  if (~clrst_if.rst_n) begin
    cycles_wo_completed_q <= 0;
  end else begin
    cycles_wo_completed_q <= cycles_wo_completed_q++;
  end

  if (cycles_wo_completed_q == TIMEOUT_CYCLES) begin
    `uvm_fatal("testbench", "Simulation timeout")
  end
end

endmodule

`endif
