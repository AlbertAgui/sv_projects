module Top_test;  

  logic a;

  initial begin
  $display("Start simulation");
  a = 1'b1;
  #10
  a = 1'b0;
  #10
  a = 1'b1;
  $display("End simulation");

  $finish;

  end

  Top_soc u_Top_soc (
  .a_i    (a)
  );

endmodule

