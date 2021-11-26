//import node_package::*;

module noc
#()
();

//node
logic clk, reset, work;

//channels
//req
wire pre_req;
logic v_req;
ReqType req;

//data
logic pre_data, v_data;
DataType data;

rn #() 
rn0(
.clk, 
.reset,
.work,
.pre_tx_req(pre_req),
.tx_req(req),
.v_tx_req(v_req),
.pre_rx_data(pre_data), 
.rx_data(data), 
.v_rx_data(v_data));

sn #()
sn0(
.clk,
.reset,
.pre_rx_req(pre_req),
.rx_req(req),
.v_rx_req(v_req),
.pre_tx_data(pre_data),
.tx_data(data),
.v_tx_data(v_data)
);

endmodule;
