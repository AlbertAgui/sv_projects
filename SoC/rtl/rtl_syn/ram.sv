module ram #(
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
  
  logic [WORD_WIDTH-1 : 0] mem_array [INDEX_WIDTH-1 : 0];
  logic [WORD_WIDTH-1 : 0] pedro;

  always_ff @(posedge clk_i) begin
    ack_wr_o = 1'b0;
    ack_rd_o = 1'b0;
    if(wr_i) begin
        mem_array [wr_index_i] = wr_data_i;
        ack_wr_o = 1'b1;
        //$display("wr_index_i: %d",wr_index_i);
        //$display("wr_data_i: %d",wr_data_i);
    end
    if(rd_i) begin
        rd_data_o = mem_array [rd_index_i];
        ack_rd_o = 1'b1;
    end
  end

endmodule