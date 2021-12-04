<<<<<<< HEAD
`include "SoC_pkg.sv"
=======
module Top_test;  
>>>>>>> 3567d14ef5907dbf6226e3855049080aaa82ce97

module Top_test;

<<<<<<< HEAD
  logic                                     clk_i;
  logic                                     arstn_i;

  logic                                     wr_i;
  logic                                     ack_wr_o;
  logic [WORD_WIDTH-1 : 0]                  wr_data_i;
  logic [INDEX_WIDTH-1 : 0]                 wr_index_i;

  logic                                     rd_i;
  logic                                     ack_rd_o;
  logic [WORD_WIDTH-1 : 0]                  rd_data_o;
  logic [INDEX_WIDTH-1 : 0]                 rd_index_i;

  //task

  task wr_mem(
  input logic [INDEX_WIDTH-1 : 0] index,
  input logic [WORD_WIDTH-1 : 0] data
  );

  wr_index_i = index;
  wr_data_i = data;
  wr_i = 1'b1;
  rd_i = 1'b0;

  endtask

  task rd_mem(
  input [INDEX_WIDTH-1 : 0] index
  );
=======
  initial begin
  $display("Start simulation");
  a = 1'b1;
  #10
  a = 1'b0;
  #10
  a = 1'b1;
  $display("End simulation");

  $finish;
>>>>>>> 3567d14ef5907dbf6226e3855049080aaa82ce97

  rd_index_i = index;
  rd_i = 1'b1;
  wr_i = 1'b0;

  endtask

  //init

  //clk
  initial begin 
    clk_i = 1'b0;
    forever clk_i = #10 ~clk_i;
  end 

  //test
  initial begin
    arstn_i = 1;
    repeat (1) @(posedge clk_i);
    arstn_i = 0;
    repeat (1) @(posedge clk_i);

    wr_mem (4'b0001,4'b0101); //wr addr 1
    @(posedge clk_i);
    rd_mem (4'b0001); //rd addr 1
    @(posedge clk_i);
    rd_mem (4'b0010); //rd addr 2
    @(posedge clk_i);
    wr_mem (4'b0001,4'b0111); //wr addr 1
    @(posedge clk_i);
    rd_mem (4'b0001); //rd addr 1
    @(posedge clk_i);
    $finish;
  end

  Top_soc #(
  .WORD_WIDTH      (WORD_WIDTH),
  .INDEX_WIDTH     (INDEX_WIDTH)
  ) u_Top_soc (
    .clk_i         (clk_i),
    .arstn_i       (arstn_i),

    .wr_i          (wr_i),
    .ack_wr_o      (ack_wr_o),
    .wr_data_i     (wr_data_i),
    .wr_index_i    (wr_index_i),

    .rd_i          (rd_i),
    .ack_rd_o      (ack_rd_o),
    .rd_data_o     (rd_data_o),
    .rd_index_i    (rd_index_i)
  );

endmodule

