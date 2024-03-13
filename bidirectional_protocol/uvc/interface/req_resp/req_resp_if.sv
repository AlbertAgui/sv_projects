`ifndef REQ_RESP_IF_SV
`define REQ_RESP_IF_SV

interface req_resp_if #(
    parameter int DATA_SIZE =  16,
    parameter string CNFG = "READY_VALID" 
);
	logic clk;
	logic rstn;
    logic req_valid;
    logic [DATA_SIZE-1:0] req_data;
    logic req_ready;
    logic resp_valid;
    logic [DATA_SIZE-1:0] resp_data;

    modport dut (
        input  clk,
        input  rstn,
        input  req_valid,
        input  req_data,
        output req_ready,
        output resp_valid,
        output resp_data
    );

    modport uvm (
        input  clk,
        input  rstn,
        output req_valid,
        output req_data,
        input  req_ready,
        input  resp_valid,
        input  resp_data
    );

    initial begin
        req_valid <= DATA_SIZE'(0);
        req_data  <= DATA_SIZE'(0);
    end

    task drive_req(
        input logic [DATA_SIZE-1:0] data
    );
        if (CNFG == "VALID_READY") begin
            req_valid <= 1'b1;
            req_data  <= data;

            do begin
                @(posedge clrst_if.clk);
            end while (!req_ready);

            req_valid <= 1'b0;
        end else if (CNFG == "READY_VALID") begin
            do begin
                @(posedge clrst_if.clk);
            end while (!req_ready);

            req_valid <= 1'b1;
            req_data  <= data;

            @(posedge clrst_if.clk);

            req_valid <= 1'b0;
        end else begin 
            $error("request: dut_top_tb CNFG == %s, not supported", CNFG); 
            $finish; 
        end
    endtask : drive_req


    task get_resp(
        output logic [DATA_SIZE-1:0] data
    );
    do begin
      @(posedge clrst_if.clk);
    end while (!resp_valid);

    data = resp_data;
    endtask : get_resp

    `ifdef ASSERTION
    always_comb begin
        if (CNFG == "VALID_READY") begin
          test_req_valid_ready: assert (!(req_valid == 1'b0 && req_ready == 1'b1))
            else begin $error("req_ready mismatch! real: %b, reference: %b", req_ready, 1'b0); $finish; end
        end else if (CNFG == "READY_VALID") begin
          test_req_ready_valid: assert (!(req_valid == 1'b1 && req_ready == 1'b0))
            else begin $error("req_ready mismatch! real: %b, reference: %b", req_ready, 1'b0); $finish; end
        end
    end
    `endif

endinterface : req_resp_if

`endif
