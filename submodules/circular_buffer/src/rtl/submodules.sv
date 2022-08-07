module circular_buffer
//import vpu_pkg::*;
#(
    parameter BUFF_SIZE = 2, //STAGE_COUNT,
    parameter DATA_WIDTH = 4*64 //NUM_LANE*WIDTH_BUFF_LANE
) (
    //..clock and reset_n
    input logic clk,
    input logic arst_n,

    //..write
    input logic wr_en_i,
    input logic [DATA_WIDTH-1 : 0] data_in_i,

    //..read
    input logic rd_en_i,
    output logic [DATA_WIDTH-1 : 0] data_out_o,

    //..state
    output logic empty_o,
    output logic full_o
);

function integer log2;
  input integer number; begin   
    log2=(number <=1) ? 1: 0;    
    while(2**log2<number) begin    
      log2=log2+1;    
    end       
  end   
endfunction // log2

//..parameter and types
parameter ADDR_SIZE = log2(BUFF_SIZE+1);//ojo
typedef logic [ADDR_SIZE-1 : 0] pointer_t;
parameter MAX_POS = BUFF_SIZE;//ojo
//..end parameter and types

//..structures and signals
logic [DATA_WIDTH-1 : 0] internal_buffer [(BUFF_SIZE + 1)-1 : 0];//ojo
pointer_t rd_pt;
pointer_t wr_pt;
//..end structures and signals


//..data
always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    data_out_o <= 0;
  end else begin
    if(wr_en_i) begin
      internal_buffer[wr_pt] <= data_in_i;
      $display("###write: %d", data_in_i);
    end
    if(rd_en_i) begin
      data_out_o <= internal_buffer[rd_pt];
      $display("###read: %d", internal_buffer[rd_pt]);
    end
  end
end
//..end data


//..pointers
always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    wr_pt <= 0;
    rd_pt <= 0;
  end else begin
    if(wr_en_i) begin
      wr_pt <= (wr_pt==MAX_POS) ? 0 : wr_pt + 1;
    end
    if(rd_en_i) begin
      rd_pt <= (rd_pt==MAX_POS) ? 0 : rd_pt + 1;
    end
  end
end
//..end pointers


//..state
assign empty_o = wr_pt == rd_pt;
assign full_o = (rd_pt == 0) ? (wr_pt == BUFF_SIZE) : (wr_pt == (rd_pt - 1));
//..end state


//..debug
always_ff @(posedge clk or negedge arst_n) begin
  if(wr_en_i && (rd_pt == 0) ? (wr_pt == BUFF_SIZE) : (wr_pt == (rd_pt - 1))) begin
    $display("attempt to write to full buffer");
    $monitor("wr_pt = %d, rd_pt = %d", wr_pt, rd_pt);
    $finish;
  end
  if(rd_en_i && (wr_pt == rd_pt)) begin
    $display("attempt to read from empty buffer");
    $monitor("wr_pt = %d, rd_pt = %d", wr_pt, rd_pt);
    $finish;
  end
end
//..end debug

endmodule




module circular_buffer_depth

//import vpu_pkg::*;
#(
    parameter BUFF_SIZE = 2, //STAGE_COUNT,
    parameter DATA_WIDTH = 4*64 //NUM_LANE*WIDTH_BUFF_LANE
) (
    //..clock and reset_n
    input logic clk,
    input logic arst_n,

    //..write
    input logic wr_en_i,
    input logic [DATA_WIDTH-1 : 0] data_in_i,

    //..read
    input logic rd_en_i,
    output logic [DATA_WIDTH-1 : 0] data_out_o,

    //..state
    output logic empty_o,
    output logic full_o
);

function integer log2;
  input integer number; begin   
    log2=(number <=1) ? 1: 0;    
    while(2**log2<number) begin    
      log2=log2+1;    
    end       
  end   
endfunction // log2

//..parameter and types
parameter ADDR_SIZE = log2(BUFF_SIZE);//ojo
typedef logic [ADDR_SIZE-1 : 0] pointer_t;

parameter MAX_POS = BUFF_SIZE-1;//ojo

parameter DEPTH_SIZE = log2(BUFF_SIZE) + 1;
typedef logic [DEPTH_SIZE-1 : 0] depth_t; 
//..end parameter and types

//..structures and signals
logic [DATA_WIDTH-1 : 0] internal_buffer [BUFF_SIZE-1 : 0];//ojo
pointer_t rd_pt;
pointer_t wr_pt;
depth_t depth;
//..end structures and signals


//..data
always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    data_out_o <= 0;
  end else begin
    if(wr_en_i) begin
      internal_buffer[wr_pt] <= data_in_i;
      $display("###write: %d", data_in_i);
    end
    if(rd_en_i) begin
      data_out_o <= internal_buffer[rd_pt];
      $display("###read: %d", internal_buffer[rd_pt]);
    end
  end
end
//..end data


//..pointers
always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    wr_pt <= 0;
    rd_pt <= 0;
  end else begin
    if (wr_en_i) begin
      wr_pt <= (wr_pt==MAX_POS) ? 0 : wr_pt + 1;
    end
    if (rd_en_i) begin
      rd_pt <= (rd_pt==MAX_POS) ? 0 : rd_pt + 1;
    end
  end
end
//..end pointers


//..depth
always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    depth <= 0;
  end else begin
    if (wr_en_i && ~rd_en_i) begin
      depth <= depth + 1;
    end
    if (rd_en_i && ~wr_en_i) begin
      depth <= depth - 1;
    end
  end
end
//..end depth


//..state
assign empty_o = (depth == 0);
assign full_o = (depth == BUFF_SIZE);
//..end state


//..debug
always_ff @(posedge clk or negedge arst_n) begin
  if(wr_en_i && (depth == BUFF_SIZE)) begin
    $display("attempt to write to full buffer");
    $monitor("wr_pt = %d, rd_pt = %d", wr_pt, rd_pt);
    $finish;
  end
  if(rd_en_i && (depth == 0)) begin
    $display("attempt to read from empty buffer");
    $monitor("wr_pt = %d, rd_pt = %d", wr_pt, rd_pt);
    $finish;
  end
end
//..end debug

endmodule