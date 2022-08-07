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


//////////

module requester(
  input logic clk,
  input logic arst_n,


  output logic valid_o,
  output logic [2:0] params_o,
  input logic grant_i
);

  logic [3:0][2:0] param_vec;
  logic [3:0] param_vec_valid;
  logic [1:0] pt;

  logic valid;

  always_ff @(posedge clk or negedge arst_n) begin
    if (~arst_n) begin
      param_vec[0] <= 2'b01; //1
      param_vec[1] <= 2'b10; //2
      param_vec[2] <= 2'b00; //1
      param_vec[3] <= 2'b00; //2

      param_vec_valid[0] <= 1'b1;
      param_vec_valid[1] <= 1'b1;
      param_vec_valid[2] <= 1'b0;
      param_vec_valid[3] <= 1'b0;

      valid <= 1'b0;
      params_o <= 2'b00;

      pt <= 1'b0;
    end else begin
      //current
      if (param_vec_valid[pt]) begin
        valid <= 1'b1;
        params_o <= param_vec[pt];
      end
      //next
      if (grant_i && valid) begin
        valid <= param_vec_valid[pt + 1'b1];//Norma, si us valors que es sincronitzen en el clk depenen d'uns altres que tmb es sincronitzen alla, fes el cas extra
        params_o <= param_vec[pt + 1'b1];
        pt <= pt +1;
      end
    end
  end

  assign valid_o = valid;
  
endmodule



module lanes(
  input logic clk,
  input logic arst_n,


  output logic valid_o,
  output logic [2:0] data_o,
  input logic grant_i
);

  logic [3:0][2:0] data_vec;
  logic [3:0] data_vec_valid;
  logic [1:0] pt;

  logic valid;

  always_ff @(posedge clk or negedge arst_n) begin
    if (~arst_n) begin
      data_vec[0] <= 2'b01; //3
      data_vec[1] <= 2'b10; //4
      data_vec[2] <= 2'b00; //3
      data_vec[3] <= 2'b00; //4

      data_vec_valid[0] <= 1'b1;
      data_vec_valid[1] <= 1'b1;
      data_vec_valid[2] <= 1'b0;
      data_vec_valid[3] <= 1'b0;
      pt <= 1'b0;
      valid <= 1'b0;
      data_o <= 2'b00;
    end else begin
      //current
      if (data_vec_valid[pt]) begin
        valid <= 1'b1;
        data_o <= data_vec[pt];
      end
      //next
      if (grant_i && valid) begin
        valid <= data_vec_valid[pt + 1'b1];
        data_o <= data_vec[pt + 1'b1];
        pt <= pt +1;
      end
    end
  end

  assign valid_o = valid;
  
endmodule



module smu(
  input logic clk,
  input logic arst_n,

  //req
  input logic req_valid_i,
  input logic [2:0] req_params_i,
  output logic req_grant_o,

  //buff
  input logic lane_valid_i,
  input logic [2:0] lane_data_i,
  output logic lane_grant_o

);

  logic [1:0][2:0] data_vec;
  logic [1:0] data_vec_valid;
  logic pt;

  logic lane_grant;
  assign lane_grant_o = lane_grant;
  
  //lane_grant_o
  always_ff @(posedge clk or negedge arst_n) begin
    if (~arst_n) begin
      data_vec[0] <= 2'b00; //3
      data_vec[1] <= 2'b00; //4

      data_vec_valid[0] <= 1'b0;
      data_vec_valid[1] <= 1'b0;
      pt <= 1'b0;
    end else begin
      //write
      if (lane_grant && lane_valid_i) begin
        data_vec_valid[pt] <= 1'b1;
        data_vec[pt] <= lane_data_i;
        pt <= pt + 1; 
      end 
    end
  end

  //fsm
  typedef enum logic[1:0] {
    idle = 2'b00,
    w = 2'b01,
    wlast = 2'b10
  } state_t;

  state_t state_d, state_q;

  logic req_grant_d, req_grant_q;
  assign req_grant_o = req_grant_q;

  //comb
  always_comb begin
    state_d = state_q;
    lane_grant = 1'b0;
    req_grant_d = req_grant_q;
    case (state_q)
      idle: begin
        req_grant_d = 1'b1;
        lane_grant = 1'b0;
        if (req_valid_i && req_grant_q) begin
          state_d = w;
          req_grant_d = 1'b0;
        end
      end
      w: begin
        req_grant_d = 1'b1;
        lane_grant = 1'b1;
        if (req_valid_i && req_grant_q) begin
          req_grant_d = 1'b0;
          state_d = wlast;
        end
      end
      wlast: begin
        lane_grant = 1'b1;
        req_grant_d = 1'b1;
        state_d = idle;
      end
      default: begin
        state_d = idle;
      end
    endcase
  end

  //seq
  always_ff @(posedge clk or negedge arst_n) begin
    if (~arst_n) begin
      state_q <= idle;
      req_grant_q <= 1'b0;
    end else begin
      state_q <= state_d;
      req_grant_q <= req_grant_d;
    end
  end
  
endmodule



