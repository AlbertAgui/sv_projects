module mod_temp();

typedef logic [2:0] l2_t;
typedef logic signed[2:0] l3_t;
typedef logic [4:0] l4_t;
typedef logic signed[4:0] l5_t;

l2_t l2;
l3_t l3;
l4_t l4;
l5_t l5;

initial begin
  l2 = l2_t'(-1);
  l3 = l3_t'(-1);
  $display("l2: %d, %b", l2,l2);
  $display("l3: %d, %b", l3,l3);

  $display("----------------");

  l4 = l4_t'(l2);
  $display("l4: %d, %b:", l4, l4);
  l4 = l4_t'(l3);
  $display("l4: %d, %b:", l4, l4);

  $display("----------------");

  l5 = l5_t'(l2);
  $display("l5: %d, %b:", l5, l5);
  l5 = l5_t'(l3);
  $display("l5: %d, %b:", l5, l5);

  $display("----------------");


  l4 = l4_t'(l3_t'(l2));
  $display("l4: %d, %b:", l4, l4);
  l4 = l4_t'(l2);
  $display("l4: %d, %b:", l4, l4);

  l5 = l5_t'(l3_t'(l2));
  $display("l4: %d, %b:", l5, l5);
  l5 = l5_t'(l2);
  $display("l4: %d, %b:", l5, l5);

  l5 = l5_t'(signed'(l2));
  $display("l4: %d, %b:", l5, l5);
  l5 = l5_t'(l2);
  $display("l4: %d, %b:", l5, l5);
end

/*  //..clock and reset_n
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
);*/

endmodule