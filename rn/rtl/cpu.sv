module cpu
import cpu_package::*;

#()
(
input logic clk,
input logic reset
);

//mem
logic [WORD_WIDTH-1:0] MEM [0:20-1];

always @(posedge clk or posedge reset) begin
  if (reset) begin
    for(int i=0; i<20; i++) begin
      MEM[i] = i[WORD_WIDTH-1:0];
    end
  end
end

//machine state
Type_pipeline_state pipe_state_temp, pipe_state;

always_comb begin
    unique case (pipe_state)
      StFetch: begin
        pipe_state_temp = StDec;
      end
      StDec: begin
        pipe_state_temp = StExec;
      end
      StExec: begin
        pipe_state_temp = StFetch;
      end
      default: begin
        pipe_state_temp = StFetch;
      end
    endcase
  end

always @(posedge clk or posedge reset) begin
    if (reset) begin
      pipe_state <= StFetch;
    end
    else begin
      pipe_state <= pipe_state_temp;
    end
  end

//fetch
logic [WORD_WIDTH-1:0]ins;
logic [5-1:0] pc;

always @(posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 'b0;
    end
    else if(pipe_state == StExec)begin
      pc <= pc + 1;
    end
  end

always @(posedge clk or posedge reset) begin
    if (reset) begin
      ins <= 'h0;
    end
    else if(pipe_state == StFetch) begin
      ins <= MEM[pc];
    end
  end

//dec
logic [3-1:0] reg_or;
logic [3-1:0] reg_dest;
logic [2-1:0] op_code;


assign reg_or = ins[5:3];
assign reg_dest = ins[2:0];
assign op_code = ins[8:6];

//exec
logic [WORD_WIDTH-1:0] RegFile [0:ADDR_WIDTH-1];
logic wp;

endmodule
