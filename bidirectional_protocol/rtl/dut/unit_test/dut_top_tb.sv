module dut_top_tb(
);

clk_rst_if clrst_if();

//clk
initial begin 
  clrst_if.clk = 1'b0;
  forever clrst_if.clk = #10 ~clrst_if.clk;
end

//test
initial begin
  clrst_if.rst_n = 1'b0;
  repeat (1) @(posedge clrst_if.clk);
  clrst_if.rst_n = 1'b1;
  repeat (1) @(posedge clrst_if.clk);
end

localparam int DATA_SIZE = 16;
localparam string CNFG = "READY_VALID";
localparam int COUNT = 3;
localparam int DEPTH = 3;
localparam int TIMEOUT = 200; //IN CYCLES

logic req_valid;
logic [DATA_SIZE-1:0] req_data;
logic req_ready;
logic resp_valid;
logic [DATA_SIZE-1:0] resp_data;

dut_top #(
  .COUNT(COUNT),
  .CNFG(CNFG),
  .DATA_SIZE(DATA_SIZE),
  .DEPTH(DEPTH)
) dut (
  .clk_i(clrst_if.clk),
  .rstn_i(clrst_if.rst_n),
  .req_valid_i(req_valid),
  .req_data_i(req_data),
  .req_ready_o(req_ready),
  .resp_valid_o(resp_valid),
  .resp_data_o(resp_data)
);

task automatic request(
  input int test_num,
  input logic [DATA_SIZE-1:0] data_test
);
begin
  if (CNFG == "VALID_READY") begin
    req_valid = 1'b1;
    req_data = data_test;

    do begin
      @(posedge clrst_if.clk);
    end while (!req_ready);

    req_valid = 1'b0;
  end else if (CNFG == "READY_VALID") begin
    do begin
      @(posedge clrst_if.clk);
    end while (!req_ready);

    req_valid = 1'b1;
    req_data = data_test;

    @(posedge clrst_if.clk);

    req_valid = 1'b0;
  end else begin 
    $error("request: dut_top_tb CNFG == %s, not supported", CNFG); 
    $finish; 
  end
end
endtask

task automatic response(
  input int test_num,
  input logic [DATA_SIZE-1:0] data_test
);
begin
    do begin
      @(posedge clrst_if.clk);
    end while (!resp_valid);

    test_data: assert (resp_data == data_test)
      else begin $error("Test %d data mismatch! real: %d, reference: %d", test_num, resp_data, data_test); $finish; end
    if (CNFG == "VALID_READY") begin
      test_req_valid_ready: assert (!(req_valid == 1'b0 && req_ready == 1'b1))
        else begin $error("Test %d req_ready mismatch! real: %b, reference: %b", test_num, req_ready, 1'b0); $finish; end
    end else if (CNFG == "READY_VALID") begin
      test_req_ready_valid: assert (!(req_valid == 1'b1 && req_ready == 1'b0))
        else begin $error("Test %d req_ready mismatch! real: %b, reference: %b", test_num, req_ready, 1'b0); $finish; end
    end
end
endtask

initial begin
  fork
    begin
      req_data = DATA_SIZE'(0);
      req_valid = 1'b0;
      @(posedge clrst_if.rst_n);
      repeat (3) @(posedge clrst_if.clk);

      fork
        //request
        begin
          //test 1
          request(1, DATA_SIZE'(10));
          //test 2
          for (int i=0; i<DEPTH; ++i) begin
            request(2, DATA_SIZE'(i+20));
          end
          //test 3
          for (int i=0; i<(DEPTH+1); ++i) begin
            request(3, DATA_SIZE'(i+30));
          end
          //test 4
          for (int i=0; i<(DEPTH*2); ++i) begin
            request(4, DATA_SIZE'(i+40));
          end
        end
        //response
        begin
          //test 1
          response(1, DATA_SIZE'(10));
          $display("Test %d Passed!", 1);
          //test 2
          for (int i=0; i<DEPTH; ++i) begin
            response(2, DATA_SIZE'(i+20));
          end
          $display("Test %d Passed!", 2);
          //test 3
          for (int i=0; i<(DEPTH+1); ++i) begin
            response(3, DATA_SIZE'(i+30));
          end
          $display("Test %d Passed!", 3);
          //test 4
          for (int i=0; i<(DEPTH*2); ++i) begin
            response(4, DATA_SIZE'(i+40));
          end
          $display("Test %d Passed!", 4);
        end
      join
    //init
    $display("All tests Passed!");
    $finish;
    end

    begin
      repeat (TIMEOUT) @(posedge clrst_if.clk);
      $display("Test Failed!");
      $error("Timeout found !!!");
      $finish; //sure? in UVM we have the error messages that work properlly with multiple threads
    end

  join
end

endmodule