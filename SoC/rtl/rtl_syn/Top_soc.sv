module Top_soc#(
  parameter WORD_WIDTH=4,
  parameter INDEX_WIDTH=4
) (
  input  logic                         clk_i,
  input  logic                         arstn_i,

  input  logic                         wr_i,
  output logic                         ack_wr_o,
  input  logic [WORD_WIDTH-1 : 0]      wr_data_i,
  input  logic [INDEX_WIDTH-1 : 0]     wr_index_i,

  input  logic                         rd_i,
  output logic                         ack_rd_o,
  output logic [WORD_WIDTH-1 : 0]      rd_data_o,
  input  logic [INDEX_WIDTH-1 : 0]     rd_index_i
);
  
  ram #(
  .WORD_WIDTH      (WORD_WIDTH),
  .INDEX_WIDTH     (INDEX_WIDTH)
  ) u_ram (
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
