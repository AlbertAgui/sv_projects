module rn
import node_package::*;

#()
(
input logic clk, 
input logic reset, 
input logic work, 
output wire pre_tx_req, 
output ReqType tx_req, 
output logic v_tx_req, 
input logic pre_rx_data, 
input DataType rx_data, 
input logic v_rx_data);

assign pre_tx_req = work; //

//RegFile
logic [WORD_WIDTH-1:0] RegFile [0:ADDR_WIDTH-1];
logic wr;

//Buffer
DataType rx_data_buffer;

///////////////////////
//STATE MACHINES

//Tx_Req
Type_chn_state req_state_temp, req_state;

always_comb begin
  v_tx_req = 1'b0;
    unique case (req_state)
      StIdle: begin
        v_tx_req = 1'b0;
        if (work) begin 
          req_state_temp = StAsserted;
        end
      end
      StAsserted: begin
        if (!pre_tx_req) begin //send data 1 cicle after pre_tx_req negedge
          v_tx_req = 1'b1;
          tx_req.opcode = op_read;
          tx_req.addr = 2'b01;
          req_state_temp = StIdle;
        end
        else begin
         req_state_temp = StAsserted;
        end
      end
      default: begin
        v_tx_req = 1'b0;
        req_state_temp = StIdle;         
      end
    endcase
  end

always @(posedge clk or posedge reset) begin
    if (reset) begin
      req_state <= StIdle;
    end
    else begin
      req_state <= req_state_temp;
    end
  end

//Rx_Data

Type_chn_state data_state_temp, data_state;

always_comb begin 
  unique case (data_state)
      StIdle: begin
        if(pre_rx_data) begin
          data_state_temp = StAsserted;
        end
      end 
      StAsserted: begin
        if(v_rx_data) begin
          data_state_temp = StIdle;
          unique case(rx_data.opcode)
            op_data_recv: begin
              wr = 1'b1;
            end
            op_no_data_recv: begin
            end
            default: begin
            end
          endcase
        end
        else begin
          data_state_temp = StAsserted;
        end
      end
      default: begin
          data_state_temp = StIdle;  
      end 
    endcase
  end 

always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      data_state <= StIdle;
      for(int i=0; i<ADDR_WIDTH; i++) begin
        RegFile[i] = i[WORD_WIDTH-1:0];
      end 
    end
    else begin
      data_state <= data_state_temp;
    end
  end

always @(posedge clk or posedge reset)
  begin
    if (!reset) begin
      if(wr)
        RegFile[rx_data.addr] = rx_data.data;
    end
    else begin
      for(int i=0; i<ADDR_WIDTH; i++) begin
        RegFile[i] = 'h0;
      end  
    end
  end

endmodule

