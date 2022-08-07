module test_sig_tb ();
//import riscv_pkg::*;
//import vpu_pkg::*;

//..signals

//..clock and reset_n
logic clk;
logic arst_n;

  //req
  logic req_valid_i;
  logic [2:0] req_params_i;
  logic req_grant_o;

  //buff
  logic lane_valid_i;
  logic [2:0] lane_data_i;
  logic lane_grant_;

//..write
/*logic wr_en_i;
logic [4*64-1 : 0] data_in_i;

//..read
logic rd_en_i;
logic [4*64-1 : 0] data1_out_o;
logic [4*64-1 : 0] data2_out_o;

//..state
logic empty1_o;
logic empty2_o;
logic full1_o;
logic full2_o;*/

//..end signals


//..clk
int count;

always #1 clk = ~clk;

always_ff @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    count <= 0;
  end else begin
    count <= count + 1;
  end
end
//..end clk

/*always_comb begin
  if ((count >= 2) && (count <= 5)) begin
    rd_en_i = 1;
  end else begin
    rd_en_i = 0;
  end
end*/


//..test
initial begin
  $display("#######");
  $display("#START#");
  $display("#######");
  clk  = 0;
  arst_n = 0;

  //wr_en_i = 0;
  //rd_en_i = 0;  
  #6;
  arst_n = 1;
  /*#1;

  //WRITE 1, depth = 1

  wr_en_i = 1;
  data_in_i = 1;

  #2;//WRITE 2, read 1, depth = 1

  wr_en_i = 1;
  //rd_en_i = 1;
  data_in_i = 2;

  //AGAIN
  #2;//WRITE 1, depth = 2

  wr_en_i = 1;
  data_in_i = 1;

  #2;//WRITE 2, read 2, depth = 2

  wr_en_i = 1;
  //rd_en_i = 1;
  data_in_i = 2;

  //extra

  #2;//read 1, depth = 1

  wr_en_i = 0;
  //rd_en_i = 1;

  #2;//read 2, depth = 0

  //rd_en_i = 0;

  #2;//finish

  wr_en_i = 0;
  //rd_en_i = 0;

  #10;
  $display("#################");
  $display("#END SUCESSFULLY#");
  $display("#################");
  #1;*/
  #20;
  $finish;
end
//..end test


//..check modules
/*always_ff @(posedge clk) begin
  if(arst_n) begin
    if(data1_out_o != data2_out_o) begin
      $display("%t: END, MODULES NOT EQUALS, data_out_o", $time);
    end
    if(empty1_o != empty2_o) begin
      $display("%t: END, MODULES NOT EQUALS, empty_o", $time);
    end
    if(full1_o != full2_o) begin
      $display("%t: END, MODULES NOT EQUALS, full_o", $time);
    end
  end
end*/
//..end check modules


//..mapping
/*circular_buffer #(
  .BUFF_SIZE(3),
  .DATA_WIDTH(4*64)
) 
u_circular_buffer (
  //..clock and reset_n
  .clk(clk),
  .arst_n(arst_n),

  //..write
  .wr_en_i(wr_en_i),
  .data_in_i(data_in_i),

  //..read
  .rd_en_i(rd_en_i),
  .data_out_o(data1_out_o),

  //..state
  .empty_o(empty1_o),
  .full_o(full1_o)
); */

/*circular_buffer_depth #(
  .BUFF_SIZE(2),
  .DATA_WIDTH(4*64)
) 
u_circular_buffer_depth (
  //..clock and reset_n
  .clk(clk),
  .arst_n(arst_n),

  //..write
  .wr_en_i(wr_en_i),
  .data_in_i(data_in_i),

  //..read
  .rd_en_i(rd_en_i),
  .data_out_o(data2_out_o),

  //..state
  .empty_o(empty2_o),
  .full_o(full2_o)
);*/

requester u_requester (
  .clk         (clk),
  .arst_n      (arst_n),
  .valid_o     (req_valid_i),
  .params_o    (req_params_i),
  .grant_i     (req_grant_o)
);


lanes u_lanes (
  .clk        (clk),
  .arst_n     (arst_n),
  .valid_o    (lane_valid_i),
  .data_o     (lane_data_i),
  .grant_i    (lane_grant_o)
);

smu u_smu (
  .clk             (clk),
  .arst_n          (arst_n),
  //req
  .req_valid_i     (req_valid_i),
  .req_params_i    (req_params_i),
  .req_grant_o     (req_grant_o),
  //buff
  .lane_valid_i    (lane_valid_i),
  .lane_data_i     (lane_data_i),
  .lane_grant_o    (lane_grant_o)
);
//..end mapping
  
endmodule
