/*module circular_buffer
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
//synthesis translate_off
//synopsys  translate_off

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
//synopsys  translate_on
//synthesis translate_on

//..end debug

endmodule*/



/*
//module circular_buffer_depth
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
localparam ADDR_SIZE = log2(BUFF_SIZE);//ojo
typedef logic [ADDR_SIZE-1 : 0] pointer_t;

localparam MAX_POS = BUFF_SIZE-1;//ojo

localparam DEPTH_SIZE = log2(BUFF_SIZE + 1);
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
      //synthesis translate_off
      //synopsys  translate_off
      $display("###write: %d", data_in_i);
      //synthesis translate_on
      //synopsys  translate_on
    end
    if(rd_en_i) begin
      data_out_o <= internal_buffer[rd_pt];
      //synthesis translate_off
      //synopsys  translate_off
      $display("###read: %d", internal_buffer[rd_pt]);
      //synthesis translate_on
      //synopsys  translate_on
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
      wr_pt <= (wr_pt==MAX_POS) ? {ADDR_SIZE{1'b0}} : wr_pt + 1'b1;
    end
    if (rd_en_i) begin
      rd_pt <= (rd_pt==MAX_POS) ? {ADDR_SIZE{1'b0}} : rd_pt + 1'b1;
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
      depth <= depth + 1'b1;
    end
    if (rd_en_i && ~wr_en_i) begin
      depth <= depth - 1'b1;
    end
  end
end
//..end depth


//..state
assign empty_o = (depth == {DEPTH_SIZE{1'b0}});
assign full_o = (depth == depth_t'(BUFF_SIZE));
//..end state


//..debug
//synthesis translate_off
//synopsys  translate_off
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
//synthesis translate_on
//synopsys  translate_on
//..end debug

endmodule
*/

/*
module circular_buffer  #(
    parameter Dw = 4*64,//data_width
    parameter B  = 2// buffer num
)(
    din,   
    wr_en, 
    rd_en, 
    dout,  
    full,
    nearly_full,
    empty,
    reset,
    clk
);

 
    function integer log2;
      input integer number; begin   
         log2=(number <=1) ? 1: 0;    
         while(2**log2<number) begin    
            log2=log2+1;    
         end       
      end   
    endfunction // log2 

    localparam  B_1 = B-1,
                Bw = log2(B),
                DEPTHw=log2(B+1);
    localparam  [Bw-1   :   0] Bint =   B_1[Bw-1    :   0];

    input [Dw-1:0] din;     // Data in
    input          wr_en;   // Write enable
    input          rd_en;   // Read the next word

    output reg [Dw-1:0]  dout;    // Data out
    output         full;
    output         nearly_full;
    output         empty;

    input          reset;
    input          clk;


*/
//reg [Dw-1       :   0] queue [B-1 : 0] /* synthesis ramstyle = "no_rw_check" */;
/*reg [Bw- 1      :   0] rd_ptr;
reg [Bw- 1      :   0] wr_ptr;
reg [DEPTHw-1   :   0] depth;

// Sample the data
always @(posedge clk)
begin
   if (wr_en)
      queue[wr_ptr] <= din;
   if (rd_en)
      dout <=
//synthesis translate_off
//synopsys  translate_off
          #1
//synopsys  translate_on
//synthesis translate_on  
          queue[rd_ptr];
end

always @(posedge clk)
begin
   if (reset) begin
      rd_ptr <= {Bw{1'b0}};
      wr_ptr <= {Bw{1'b0}};
      depth  <= {DEPTHw{1'b0}};
   end
   else begin
      if (wr_en) wr_ptr <= (wr_ptr==Bint)? {Bw{1'b0}} : wr_ptr + 1'b1;
      if (rd_en) rd_ptr <= (rd_ptr==Bint)? {Bw{1'b0}} : rd_ptr + 1'b1;
      if (wr_en & ~rd_en) depth <=
//synthesis translate_off
//synopsys  translate_off
                   #1
//synopsys  translate_on
//synthesis translate_on  
                   depth + 1'b1;
      else if (~wr_en & rd_en) depth <=
//synthesis translate_off
//synopsys  translate_off
                   #1
//synopsys  translate_on
//synthesis translate_on  
                   depth - 1'b1;
   end
end

//assign dout = queue[rd_ptr];
assign full = depth == B;
assign nearly_full = depth >= B-1;
assign empty = depth == {DEPTHw{1'b0}};

//synthesis translate_off
//synopsys  translate_off
always @(posedge clk)
begin
    if(~reset)begin
       if (wr_en && depth == B && !rd_en)
          $display(" %t: ERROR: Attempt to write to full FIFO: %m",$time);
       if (rd_en && depth == {DEPTHw{1'b0}})
          $display("%t: ERROR: Attempt to read an empty FIFO: %m",$time);
    end//~reset
end
//synopsys  translate_on
//synthesis translate_on

endmodule // fifo
*/



/*module circular_buffer(out, addr, CS);
output[15:0] out;
input[3:0] addr;
input CS;
logic [15:0] out;
logic [15:0] ROM[15:0];
always @(negedge CS)
begin
ROM[0]=16'h5601; ROM[1]=16'h3401;
ROM[2]=16'h1801; ROM[3]=16'h0ac1;
ROM[4]=16'h0521; ROM[5]=16'h0221;
ROM[6]=16'h5601; ROM[7]=16'h5401;
ROM[8]=16'h4801; ROM[9]=16'h3801;
ROM[10]=16'h3001; ROM[11]=16'h2401;
ROM[12]=16'h1c01; ROM[13]=16'h1601;
ROM[14]=16'h5601; ROM[15]=16'h5401;
out=ROM[addr];
end
endmodule*/



/*
 //-----------------------------------------------------
 // Design Name : cam
 // File Name   : cam.v
 // Function    : CAM
 // Coder       : Deepak Kumar Tala
 //-----------------------------------------------------
 module circular_buffer (
 clk         , // Cam clock
 cam_enable  , // Cam enable
 cam_data_in , // Cam data to match
 cam_hit_out , // Cam match has happened
 cam_addr_out  // Cam output address 
 );
 
 parameter ADDR_WIDTH  = 8;
 parameter DEPTH       = 1 << ADDR_WIDTH;
 //------------Input Ports--------------
 input                    clk;      
 input                    cam_enable;   
 input  [DEPTH-1:0]       cam_data_in;  
 //----------Output Ports--------------
 output                   cam_hit_out;  
 output [ADDR_WIDTH-1:0]  cam_addr_out;  
 //------------Internal Variables--------
 reg [ADDR_WIDTH-1:0]  cam_addr_out;
 reg                   cam_hit_out;
 reg [ADDR_WIDTH-1:0]  cam_addr_combo;
 reg                   cam_hit_combo;
 reg                   found_match;
 integer               i;
 //-------------Code Starts Here-------
 always @(cam_data_in) begin
   cam_addr_combo   = {ADDR_WIDTH{1'b0}};
   found_match      = 1'b0;
   cam_hit_combo    = 1'b0;
   for (i=0; i<DEPTH; i=i+1) begin
     if (cam_data_in[i] &&  ! found_match) begin
       found_match     = 1'b1;
       cam_hit_combo   = 1'b1;
       cam_addr_combo  = i;
     end else begin
       found_match     = found_match;
       cam_hit_combo   = cam_hit_combo;
       cam_addr_combo  = cam_addr_combo;
     end
   end
 end
 
 // Register the outputs 
 always @(posedge clk) begin
   if (cam_enable) begin
     cam_hit_out  <=  cam_hit_combo;
     cam_addr_out <=  cam_addr_combo;
   end else begin
     cam_hit_out  <=  1'b0;
     cam_addr_out <=  {ADDR_WIDTH{1'b0}};
   end
 end
 
 endmodule 
*/

/*
 module circular_buffer (
input d, 
input ena,
output q);
always @(*)
    begin
        if(ena==1'b1)
            q=d;
        else
            q=q;
    end endmodule
*/





















// Quartus II Verilog Template
// True Dual Port RAM with single clock

module dual_port_ram
#(
    parameter Dw=8, 
    parameter Aw=6,
    parameter INITIAL_EN= "NO",
    parameter INIT_FILE= "sw/ram/ram0.txt"// ram initial file 
)
(
   data_a,
   data_b,
   addr_a,
   addr_b,
   we_a,
   we_b,
   clk,
   q_a,
   q_b
);


    input [(Dw-1):0] data_a, data_b;
    input [(Aw-1):0] addr_a, addr_b;
    input we_a, we_b, clk;
    output  reg [(Dw-1):0] q_a, q_b;

    // Declare the RAM variable
    reg [Dw-1:0] ram[2**Aw-1:0];

	// initial the memory if the file is defined
	generate 
	    /* verilator lint_off WIDTH */
		if (INITIAL_EN == "YES") begin : init
		/* verilator lint_on WIDTH */
		    initial $readmemh(INIT_FILE,ram);
		end
	endgenerate


    // Port A 
    always @ (posedge clk)
    begin
        if (we_a) 
        begin
            ram[addr_a] <= data_a;
            q_a <= data_a;
        end
        else 
        begin
            q_a <= ram[addr_a];
        end 
    end 

    // Port B 
    always @ (posedge clk)
    begin
        if (we_b) 
        begin
            ram[addr_b] <= data_b;
            q_b <= data_b;
        end
        else 
        begin
            q_b <= ram[addr_b];
        end 
    end

 
   
endmodule






























//////////////////////////////////////////////////////////////////////////////////////////////////
//  TITLE:                  Behavioral -  Store Management Unit                                   //
//                                                                                              //
//  PROJECT:                eProcessor - VPU                                                    //
//  LANGUAGE:               Verilog, SystemVerilog                                              //
//                                                                                              //
//  AUTHOR(s):              Albert Aguilera Dangla - albert.aguilera@bsc.es (AA)                //
//                          Alberto Gonzalez Trejo - alberto.gonzalez@bsc.es (AG)               //
//                                                                                              //
//  REVISION:               1.0 - First functional implementation. (AA,AG)                      //
//                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Zero extension for signals, x = final bitwidth, y = signal to extend,
 * could be a size defined constant e.g. 1'd1
 */
`define _ZERO_EXT_(x,y) {{x-$bits(y){'0}},y}

module mod_smu
import riscv_pkg::*;
import vpu_pkg::*;
(
  //..clock and reset_n
  input logic clk,
  input logic arst_n,

  //..lanes interface
  //..initial request
  output logic lanes_req_o,
  input logic lanes_gnt_i,
  //..data messages
  input buffers_data_t lanes_data_i,
  input logic lanes_valid_i,
  output logic lanes_read_en_o,
  input buffers_elem_ids_t lanes_elem_ids_i,

  //..request queue interface
  //..input
  input logic req_data_valid_i,
  output logic req_data_grant_o,
  input vpu_pkg::sb_id_t req_sb_id_i,//necessary?
  input vpu_pkg::mem_op_mode_e req_mode_i,
  input riscv_pkg::xlen_t req_stride_i,
  input vpu_pkg::vsew_e req_vsew_i,
  input vpu_pkg::elem_id_t req_elem_id_i,
  input vpu_pkg::elem_count_t req_elem_cnt_i,
  input vpu_pkg::elem_offset_t req_elem_offset_i,
  //input vlen, añadir

  //..output
  output logic [NUM_LANE-1 : 0] req_data_valid_o,
  input logic [NUM_LANE-1 : 0] req_data_grant_i,
  output vpu_pkg::l2_cache_line_t req_data_o,
  output vpu_pkg::l2_cache_line_t req_dataa_o,//fix, eliminate
  output vpu_pkg::sb_id_t req_sb_id_o
);

//..get req_stride_i absolute value
logic reverse;
riscv_pkg::xlen_t n_stride;
//not reverse in index mode
assign reverse = (req_stride_i[riscv_pkg::XLEN-1] == 1) && (req_mode_i == Strided);

assign n_stride = reverse == 1 ? - req_stride_i : req_stride_i;
//..end get req_stride_i absolute value


//..buffering
localparam PIECES = L2_CACHE_LINE_BITS/WIDTH_BUFF_LANE;

logic empty_b, full_b;
logic wr_b, rd_b;

logic [NUM_LANE-1 : 0][WIDTH_BUFF_LANE-1 : 0] buffer_data_i;
logic [PIECES-1 : 0][WIDTH_BUFF_LANE-1 : 0] buffer_data_out;


generate
  for(genvar i=0; i<L2_CACHE_LINE_BYTES; ++i) begin: internal_buffer_inst

  dual_port_ram #(
    .Dw            (8),
    .Aw            (6),
    .INITIAL_EN    ("NO"),
    // ram initial file 
    .INIT_FILE     ("sw/ram/ram0.txt")
  ) u_dual_port_ram (
    .data_a        (data_a),
    .data_b        (data_b),
    .addr_a        (addr_a),
    .addr_b        (addr_b),
    .we_a          (we_a),
    .we_b          (we_b),
    .clk           (clk),
    .q_a           (q_a),
    .q_b           (q_b)
  );

  end
endgenerate

//..buffer write control
assign wr_b = req_data_valid_i && ~full_b;

always_ff @(posedge clk or negedge arst_n) begin
  if(~arst_n) begin
    lanes_read_en_o <= 0;
  end else begin
    if(wr_b) begin
    lanes_read_en_o <= 1;
    end else begin
      lanes_read_en_o <= 0;
    end
  end
end
//..end buffer write control

//..end buffering


/*
//..inverter

//..inverter data
vpu_pkg::l2_cache_line_t norm_data;

data_reversal_module #(
  .N(64),
  .WIDTH(8)
) u_data_reversal_module (
  .sew(req_vsew_i),
  .reverse(reverse),
  .data_input(norm_data),
  .data_output(req_dataa_o)
);

//..end inverter data

//..end inverter



  //..map functions
  //..get lane map
  function automatic vpu_pkg::l2_cache_line_idx_t get_lane_map
  (vpu_pkg::vlen_t req_elem_id_i, vpu_pkg::vsew_e req_vsew_i);
      return (req_elem_id_i / (MAX_VSEW_BYTES/vpu_pkg::vsew_bytes(req_vsew_i)) ) % NUM_LANE;//
    //  return (req_elem_id_i/(elem_buff)) % num_lane, 
    //elem_buff = bytes max_vsew/ bytes vsew
  endfunction

  logic[$clog2(NUM_LANE)-1 : 0] lane_map;

  assign lane_map = get_lane_map(req_elem_id_i, req_vsew_i);

  //..end get lane map

  //..get bank map
  function automatic vpu_pkg::l2_cache_line_idx_t get_bank_map
  (vpu_pkg::vlen_t req_elem_id_i, vpu_pkg::vsew_e req_vsew_i);
      return (req_elem_id_i % ((WIDTH_BUFF_LANE/8)/vpu_pkg::vsew_bytes(req_vsew_i)));//
    //  return (req_elem_id_i % elem_buff)
    //elem_buff = bytes max_vsew/ bytes vsew
  endfunction

  logic[$clog2(NUM_BANK)-1 : 0] bank_map;

  assign bank_map = get_bank_map(req_elem_id_i, req_vsew_i);

  //..end get bank map

  //..end map functions



  //..map temp_data
  vpu_pkg::l2_cache_line_t req_data_q;

  assign req_data_o = req_data_q;

  vpu_pkg::l2_cache_line_t data_lane;

  int d_bit, d_count, d_done;

  l2_cache_line_element_idx_bit_t d_dest_index;

  logic[$clog2(NUM_LANE)-1 : 0] temp_lane_map;
  logic[$clog2(NUM_BANK)-1 : 0] temp_bank_map;

always_comb begin
  d_bit = 0;
  d_count = 0;
  d_done = 0;

  d_dest_index = (((bank_map) * vpu_pkg::vsew_bytes(req_vsew_i)) * 8
      + lane_map * WIDTH_BUFF_LANE) % L2_CACHE_LINE_BITS;

  while(((d_done == 0) && (d_bit <= d_dest_index)) || ((d_done == 1) && (d_bit != d_dest_index))) begin    
    //find start
    if((d_done == 0) && (d_bit == d_dest_index)) begin
      //compute all bits from all elen
      while(d_count < req_elem_cnt_i) begin
        temp_lane_map = get_lane_map(req_elem_id_i + d_count, req_vsew_i);
        temp_bank_map = get_bank_map(req_elem_id_i + d_count, req_vsew_i);
        //set data bits
        for(int i = 0; i < vsew_bytes(req_vsew_i) * 8; ++i) begin
          req_data_q [(d_bit + i) % L2_CACHE_LINE_BITS] = 
          lanes_data_i[temp_lane_map][(temp_bank_map * vsew_bytes(req_vsew_i)*8) + i];
        end
          //set new d_bit possition
          d_bit = (d_bit + vsew_bytes(req_vsew_i) * 8) % L2_CACHE_LINE_BITS;
          //iterate on next element
          ++d_count;
      end
      //all elements iterated
      d_done = 1'b1;
    end else begin //not find elen
      req_data_q [d_bit] = 1'b0;
      d_bit = (d_bit + 1) % L2_CACHE_LINE_BITS;
    end  
  end
end
  //..end map temp_data


//..map data
l2_cache_line_element_idx_bit_t dt_source_index;
l2_cache_line_element_idx_bit_t dt_dest_index;

int dt_bit,dt_count,dt_done;

always_comb begin
  dt_bit = 0;
  dt_count = 0;
  dt_done = 0;

  //Bad practice?
  norm_data = 0;

  dt_dest_index = (((bank_map) * vpu_pkg::vsew_bytes(req_vsew_i)) * 8
      + lane_map * WIDTH_BUFF_LANE) % L2_CACHE_LINE_BITS;

  while(((dt_done == 0) && (dt_bit <= dt_dest_index)) || ((dt_done == 1) && (dt_bit != dt_dest_index))) begin    
    //find start
    if((dt_done == 0) && (dt_bit == dt_dest_index)) begin
      //compute all bits from all elen
      while(dt_count < req_elem_cnt_i) begin
        dt_source_index = (dt_count * n_stride + req_elem_offset_i) * 8;

        //set data bits
        for(int i = 0; i < vsew_bytes(req_vsew_i) * 8; ++i) begin
          norm_data [dt_source_index + i] = req_data_q [(dt_bit + i) % L2_CACHE_LINE_BITS];
        end
          //set new dt_bit possition
          dt_bit = (dt_bit + vsew_bytes(req_vsew_i) * 8) % L2_CACHE_LINE_BITS;
          //iterate on next element
          ++dt_count;
      end
      //all elements iterated
      dt_done = 1'b1;
    end else begin //not find elen
      //req_dataa_o[dt_bit] = 1'b0;
      dt_bit = (dt_bit + 1) % L2_CACHE_LINE_BITS;
    end  
  end
end

//..end map data

  //..request
  logic req_data_valid_d, req_data_valid_q;
  logic req_data_grant_d, req_data_grant_q;
  //..end request

  //..buffer
  logic lanes_data_grant_d, lanes_data_grant_q;
  //..end buffer

  //..fsm states
  typedef enum logic [1 : 0]{
    Idle = 2'b00,
    Work = 2'b01,
    Last = 2'b10
  } mod_smu_state_e;

  //..end fsm states

  //..fsm - combinatorial
  mod_smu_state_e state_d,state_q;

  always_comb begin
    req_data_valid_d = req_data_valid_q;
    req_data_grant_d = req_data_grant_q;
    lanes_data_grant_d = lanes_data_grant_q;
    state_d = state_q;
    case (state_q)
      Idle: begin
        //new data
        if(lanes_valid_i && req_data_valid_i) begin
          req_data_valid_d = 1;
          req_data_grant_d = 0;
          lanes_data_grant_d = 0;
          state_d = Work;
        //no new data
        end else begin
          req_data_valid_d = 0;
          req_data_grant_d = 1;
          lanes_data_grant_d = 1;
        end
      end
      //not last req
      Work: begin
        if(lanes_data_last_i) begin
          state_d = Last;
        end
      end
      //last req
      Last: begin
        req_data_valid_d = 0;
        req_data_grant_d = 1;
        lanes_data_grant_d = 1;
        state_d = Idle;
      end
      default: begin
      end
    endcase
  end
  //..end fsm - combinatorial

  
  //..fsm - sequential
  always_ff @(posedge clk or negedge arst_n) begin
    if(~arst_n) begin
      req_data_valid_q <= 0;
      req_data_grant_q <= 0;
      lanes_data_grant_q <= 0;
      state_q <= Idle;
    end else begin
      req_data_valid_q <= req_data_valid_d;
      req_data_grant_q <= req_data_grant_d;
      lanes_data_grant_q <= lanes_data_grant_d;
      state_q <= state_d;
    end
  end
  //..end fsm - sequential

  //..end fsm

  assign req_data_valid_o = req_data_valid_q;
  assign req_data_grant_o = req_data_grant_q;
  assign lanes_read_en_o = lanes_data_grant_q;
  
endmodule
*/

/*..Expected future work to do in this version
1-sequentialize buffer data input
2-synchronization signals
3-change interface
4-clean code

5-add displays and signals to wave.do
*/

/*..dudas
1-set xs values from dataa to 0 - Strange aproach

1-En request queue interface input, la mask es necessaria?
Abraham dijo que si, en que formato llega?Porque dependiendo del formato,
no se debe modificar y por tanto no es necessario.
2-En el output debe haber alguna direccion de mem?
3-El elem_ids_i de los buffers se debe sustituir por direcciones de mem?
4-req_elem_id_i ??

5-Comprobar con una cam, qual de los elem_ids es el mas pequeño?

6-Caso extremo, accedimos al elem_id 255 i al 0 ?, (la direccion + stride,
puede hacer overflow?)

7-Es necessario el behavioural del store buffer? y del load buffer?

8-En que orden manda los datos el store buffer?

9-El elem_id es 0 la mayor parte del tiempo, como aprovecharlo?
*/