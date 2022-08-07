module mod_temp();

  //..clock and reset_n
  logic clk;
  logic arst_n;

  //..request
  logic valid_i;
  logic ready_o;

  //..slave
  logic valid_o;
  logic ready_i;

  //..clock
  always begin
    #1 clk = ~clk;
  end

  //..reset_n
  always
    #10 arst_n = 1'b1;

initial begin
  clk = 1'b0;
  arst_n = 1'b0;
  #11;
  arst_n = 1'b1;

  ready_i = 1'b1;

  valid_i = 1'b1;
  #2;valid_i = 1'b0;

  #10;

  $finish;
end

temp u_temp (
  //..clock and reset_n
  .clk        (clk),
  .arst_n     (arst_n),
  //..request
  .valid_i    (valid_i),
  .ready_o    (ready_o),
  //..slave
  .valid_o    (valid_o),
  .ready_i    (ready_i)
);
  
endmodule