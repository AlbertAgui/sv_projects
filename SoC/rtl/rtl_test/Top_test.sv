module Top_test();

  logic a;

  initial begin

  a = 1'b1;
  #10
  a = 1'b0;
  #10
  a = 1'b1;

  end

  Top_soc u_Top_soc (
  .a_i    (a)
  );

endmodule

