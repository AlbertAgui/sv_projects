interface dut_if;
	logic clk;    // Clock
	logic rst_n;  // Asynchronous reset active low

	logic [7:0] a;
	logic [7:0] b;
endinterface : dut_if

interface clk_rst_if;
	logic clk;    // Clock
	logic rst_n;  // Asynchronous reset active low	
endinterface : clk_rst_if

interface data_if;
	logic [7:0] data;	
endinterface : data_if