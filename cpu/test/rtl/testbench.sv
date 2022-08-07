module testbench;

  logic clk;
  logic arstn;

  //init

  //clk
  initial begin 
    clk = 1'b0;
    forever clk = #10 ~clk;
  end 

  //test
  initial begin
    arstn = 0;
    repeat (1) @(posedge clk);
    arstn = 1;
    repeat (1) @(posedge clk);

    repeat (30) @(posedge clk);
    $finish;
  end

  top_cpu #(
  )
  top_cpu_u
  (
    .clk        (clk),
    .arstn       (arstn)
  );

endmodule

