module dut_top 
#(
	parameter int COUNT = 10,
	parameter string CNFG = "VALID_READY",
	parameter int DATA_SIZE =  16,
	parameter int DEPTH = 3
)

(
	input  logic clk_i,    // Clock
	input  logic rstn_i,  // Asynchronous reset active low
	input  logic req_valid_i,
	input  logic [DATA_SIZE-1:0] req_data_i,
	output logic req_ready_o,
	output logic resp_valid_o,
	output logic [DATA_SIZE-1:0] resp_data_o
);

localparam byte REQ_NUM_STATES = 3;
localparam byte B_REQ_NUM_STATES = $clog2(REQ_NUM_STATES);
typedef enum logic[B_REQ_NUM_STATES-1 : 0] {
	REQ_COUNT,
	REQ_UNSET,
	REQ_SET
} req_state_t;

localparam byte RESP_NUM_STATES = 3;
localparam byte B_RESP_NUM_STATES = $clog2(RESP_NUM_STATES);
typedef enum logic[B_RESP_NUM_STATES-1 : 0] {
	RESP_COUNT,
	RESP_UNSET,
	RESP_SET
} resp_state_t;

req_state_t  req_state_d, req_state_q;
resp_state_t resp_state_d, resp_state_q;

localparam B_COUNT = $clog2(COUNT+1);
logic [B_COUNT-1:0] req_counter_d, req_counter_q;
logic [B_COUNT-1:0] resp_counter_d, resp_counter_q;

logic req_queue_ready_d, req_queue_ready_q;
logic req_queue_ready;

localparam RESP_RESOURCES = 4;
localparam B_RESP_RESOURCES = $clog2(RESP_RESOURCES+1);
logic [B_RESP_RESOURCES-1:0] resp_resources_d, resp_resources_q;
logic resp_queue_ready_d, resp_queue_ready_q;
logic resp_queue_valid;

logic req_set, req_unset;
logic resp_set, resp_unset;

logic queue_wr;

always_comb begin
	resp_resources_d = resp_resources_q;
	if(resp_queue_ready_q && resp_queue_valid) begin
		resp_resources_d = resp_resources_q - B_RESP_RESOURCES'(1);
	end
	if(resp_state_q == RESP_UNSET && (resp_resources_q != RESP_RESOURCES)) begin
		resp_resources_d = resp_resources_q + B_RESP_RESOURCES'(1);
	end
end

always_ff @(posedge clk_i or negedge rstn_i) begin
	if(~rstn_i) begin
		resp_resources_q <= B_RESP_RESOURCES'(RESP_RESOURCES);
	end else begin
		resp_resources_q <= resp_resources_d;
	end
end

always_comb begin
	req_state_d       = req_state_q;
	req_counter_d     = req_counter_q;
	req_queue_ready_d = req_queue_ready_q;
	case (req_state_q)
		REQ_COUNT: begin
			if(req_counter_q == COUNT) begin
				req_state_d   = REQ_UNSET;
			end else begin
				req_counter_d = req_counter_q + B_COUNT'(1);
			end
		end
		REQ_UNSET: begin
			if (req_set) begin
				req_queue_ready_d = 1'b1; //not here in both configs
				req_state_d   = REQ_SET;
			end
		end
		REQ_SET: begin
			if (req_unset) begin
				req_counter_d     = B_COUNT'(0);
				req_state_d       = REQ_COUNT;
				req_queue_ready_d = 1'b0;
			end
		end
		/*default: begin
			$error("req_state_q not supported");
		end*/
	endcase
end

always_comb begin
	resp_queue_ready_d = resp_queue_ready_q;
	resp_state_d = resp_state_q;
	case (resp_state_q)
		RESP_COUNT: begin
			if(resp_counter_q == COUNT) begin
				resp_state_d   = RESP_UNSET;
			end else begin
				resp_counter_d = resp_counter_q + B_COUNT'(1);
			end
		end
		RESP_UNSET: begin
			if (resp_set) begin
				resp_state_d = RESP_SET;
				resp_queue_ready_d = 1'b1;
			end else begin
				resp_queue_ready_d = 1'b0;
			end
		end
		RESP_SET: begin
			if (resp_unset) begin
				resp_state_d = RESP_COUNT;
				resp_queue_ready_d = 1'b0;
			end else begin
				resp_queue_ready_d = 1'b1;
			end
		end
		/*default: begin
			$error("resp_state_q not supported");
		end*/
	endcase
end

always_ff @(posedge clk_i or negedge rstn_i) begin
	if (~rstn_i) begin
		req_state_q        <= REQ_COUNT;
		resp_state_q       <= RESP_COUNT;
		req_counter_q      <= B_COUNT'(0);
		resp_counter_q     <= B_COUNT'(0);
		resp_queue_ready_q <= 1'b0;
		req_queue_ready_q  <= 1'b0;
	end else begin
		req_state_q        <= req_state_d;
		resp_state_q       <= resp_state_d;
		req_counter_q      <= req_counter_d;
		resp_counter_q     <= resp_counter_d;
		resp_queue_ready_q <= resp_queue_ready_d;
		req_queue_ready_q  <= req_queue_ready_d;
	end
end

queue #(
	.DATA_SIZE (DATA_SIZE),
	.DEPTH     (DEPTH),
	.CNFG      ("READY_VALID") //"READY_VALID" required in current implementation
) req_queue (
	.clk_i      (clk_i),
	.rstn_i     (rstn_i),
	
	.wr_valid_i (queue_wr),
	.wr_ready_o (req_queue_ready),
	.wr_data_i  (req_data_i),
	.rd_valid_o (resp_queue_valid),
	.rd_veady_i (resp_queue_ready_q),
	.rd_data_o  (resp_data_o)
);

assign resp_valid_o = resp_queue_valid;

//HANDSHAKE PROTOCOL
if (CNFG == "VALID_READY") begin
	assign queue_wr    = req_queue_ready_d;
	assign req_ready_o = req_queue_ready_d && req_valid_i; //wr signal
	assign req_set     = req_valid_i && req_queue_ready;
	assign req_unset   = !req_valid_i || !req_queue_ready;
	assign resp_set    = resp_resources_d == RESP_RESOURCES;
	assign resp_unset  = resp_resources_d == 0;
end else if (CNFG == "READY_VALID") begin
	assign queue_wr    = req_queue_ready_d && req_valid_i;
    assign req_ready_o = req_queue_ready_d;
	assign req_set     = req_queue_ready;
	assign req_unset   = !req_queue_ready;
	assign resp_set    = resp_resources_d == RESP_RESOURCES;
	assign resp_unset  = resp_resources_d == 0;
end else begin
    $error("not supported config");
end

`ifdef ASSERTION
always_ff @(posedge clk_i or negedge rstn_i) begin
	if (rstn_i) begin
		req_fsm_invalid_state: assert final (req_state_q == REQ_UNSET || req_state_q == REQ_SET || req_state_q == REQ_COUNT)
			else $error("Assertion %m failed!");
		resp_fsm_invalid_state: assert final (resp_state_q == RESP_UNSET || resp_state_q == RESP_SET || resp_state_q == RESP_COUNT)
			else $error("Assertion %m failed!");
		check_not_resp_resources: assert final (! ((resp_queue_ready_q && resp_queue_valid) && (resp_resources_q == 0)))
			else $error("Assertion %m failed!");
		resp_resources_up_treshold: assert final ((B_RESP_RESOURCES+1)'(resp_resources_q) < (B_RESP_RESOURCES+1)'(RESP_RESOURCES+1))
            else $error("Assertion %m failed!");
	end
end
`endif



endmodule : dut_top
