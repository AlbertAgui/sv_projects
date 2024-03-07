module queue #(
    parameter int DATA_SIZE =  16,
    parameter int DEPTH = 4,
    parameter string CNFG = "VALID_READY" //"VALID_READY", "READY_VALID"
)
(
    input  logic                 clk_i,    // Clock
	input  logic                 rstn_i,  // Asynchronous reset active low
    input  logic                 wr_valid_i,
    output logic                 wr_ready_o,
    input  logic [DATA_SIZE-1:0] wr_data_i,
    output logic                 rd_valid_o,
    input  logic                 rd_veady_i,
    output logic [DATA_SIZE-1:0] rd_data_o
);
localparam B_DEPTH_CNT = $clog2(DEPTH+1);
logic [B_DEPTH_CNT-1:0] depth_cnt_d, depth_cnt_q;

logic [DATA_SIZE-1:0] queue [DEPTH-1:0];

localparam B_DEPTH = $clog2(DEPTH);
logic [B_DEPTH-1:0] wr_pt_d, wr_pt_q;
logic [B_DEPTH-1:0] rd_pt_d, rd_pt_q;

logic full, empty;
logic write, read;

assign full  = (depth_cnt_q == B_DEPTH_CNT'(DEPTH));
assign empty = (depth_cnt_q == B_DEPTH_CNT'(0));
assign write = (!full && wr_valid_i);
assign read  = (!empty && rd_veady_i);

//HANDSHAKE PROTOCOL
if (CNFG == "VALID_READY") begin
    assign wr_ready_o = write;
    assign rd_valid_o  = !empty && rstn_i;
end else if (CNFG == "READY_VALID") begin
    assign wr_ready_o = !full && rstn_i;
    assign rd_valid_o  = read;
end else begin
    $error("not supported config");
end


always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i) begin
        queue <= '{default:'0};
    end else begin
        if (write) begin
            queue[wr_pt_q] <= wr_data_i;
        end
    end
end

assign rd_data_o  = queue[rd_pt_q];

always_comb begin
    depth_cnt_d = depth_cnt_q;
    if (write && !read) begin
        depth_cnt_d = depth_cnt_q + B_DEPTH_CNT'(1); 
    end else if (!write && read) begin
        depth_cnt_d = depth_cnt_q - B_DEPTH_CNT'(1); 
    end
end

always_comb begin
    wr_pt_d = wr_pt_q;
    rd_pt_d = rd_pt_q;
    if (write) begin
        wr_pt_d = (wr_pt_q == (DEPTH-1))? B_DEPTH'(0) : wr_pt_q + B_DEPTH'(1);
    end
    if (read) begin
        rd_pt_d = (rd_pt_q == (DEPTH-1))? B_DEPTH'(0) : rd_pt_q + B_DEPTH'(1);
    end
end

always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i) begin
        depth_cnt_q <= B_DEPTH_CNT'(0);
    end else begin
        depth_cnt_q <= depth_cnt_d;
    end
end

always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i) begin
        wr_pt_q <= B_DEPTH'(0);
        rd_pt_q <= B_DEPTH'(0);
    end else begin
        wr_pt_q <= wr_pt_d;
        rd_pt_q <= rd_pt_d;
    end
end

`ifdef ASSERTION
always_ff @(posedge clk_i or negedge rstn_i) begin
    if (rstn_i) begin
        rd_pointer_up_treshold: assert final ((B_DEPTH_CNT+1)'(rd_pt_q) < (B_DEPTH+1)'(DEPTH))
            else $error("Assertion %m failed!");
        wr_pointer_up_treshold: assert final ((B_DEPTH_CNT+1)'(wr_pt_q) < (B_DEPTH+1)'(DEPTH))
            else $error("Assertion %m failed!");
        depth_up_treshold: assert final ((B_DEPTH_CNT+1)'(depth_cnt_q) < (B_DEPTH_CNT+1)'(DEPTH+1))
            else $error("Assertion %m failed!");
        write_condition: assert final (! (write && full))
            else $error("Assertion %m failed!");
        read_condition: assert final (! (read && empty))
            else $error("Assertion %m failed!");
    end
end
`endif
endmodule