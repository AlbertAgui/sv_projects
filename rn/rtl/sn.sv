module sn
import node_package::*;

#()
(
input logic clk, 
input logic reset, 
input logic pre_rx_req, 
input ReqType rx_req, 
input logic v_rx_req, 
output logic pre_tx_data, 
output DataType tx_data, 
output logic v_tx_data);

//RegFile
logic [WORD_WIDTH-1:0] RegFile [0:ADDR_WIDTH-1];

//Buffer
ReqType rx_req_buffer;

///////////////////////
//STATE MACHINES

always @(posedge clk or posedge reset) begin
  if (reset) begin
    for(int i=0; i<ADDR_WIDTH; i++) begin
      RegFile[i] = i[WORD_WIDTH-1:0];
    end
  end
end


//Rx_Req

Type_chn_state req_state_temp, req_state;

always_comb begin
  unique case (req_state)
      StIdle: begin
        if(pre_rx_req) begin
          req_state_temp = StAsserted;
        end
      end
      StAsserted: begin
        if(v_rx_req) begin
          req_state_temp = StIdle;
          rx_req_buffer.opcode = rx_req.opcode;
          rx_req_buffer.addr = rx_req.addr;
        end
        else begin
          req_state_temp = StAsserted;
        end
      end
      default: begin
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

//Tx_Data

Type_chn_state data_state_temp, data_state;

always_comb begin
  v_tx_data = 1'b0;
    unique case (data_state)
      StIdle: begin
        v_tx_data = 1'b0;
        if (v_rx_req) begin
          data_state_temp = StAsserted;
          pre_tx_data = 1'b1;
        end
      end
      StAsserted: begin
          pre_tx_data = 1'b0;
          v_tx_data = 1'b1;
          tx_data.opcode = op_data_recv;
          tx_data.addr = rx_req_buffer.addr;
          unique case (data_state)
            op_read: begin
              tx_data.data = RegFile[rx_req_buffer.addr];
            end
            op_write: begin
            end
            default: begin
            end
          endcase
          data_state_temp = StIdle;
      end
      default: begin
        v_tx_data = 1'b0;
        data_state_temp = StIdle;
      end
    endcase
  end     
        
always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_state <= StIdle;
    end   
    else begin
      data_state <= data_state_temp;
    end   
  end   

endmodule

