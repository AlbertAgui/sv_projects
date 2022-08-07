module temp(
  //..clock and reset_n
  input logic clk,
  input logic arst_n,

  //..request
  input logic valid_i,
  output logic ready_o,

  //..slave
  output logic valid_o,
  input logic ready_i

);

/*//fsm
//..fsm sig and type
typedef enum logic {
  Idle,
  Busy
} state_e;

state_e state_d, state_q;
//end fsm

logic action_d, action_q;
logic reaction_d, reaction_q;

logic resp;

assign ready_o = 1'b1;
assign valid_o = 1'b1;

assign resp = (state_q == Idle) ? reaction_d : reaction_q;


always_comb begin
  action_d = action_q;
  state_d = state_q;
  if(ready_o && valid_i) begin
    action_d = 1'b1;
    state_d = Busy;
  end else begin
    action_d = 1'b0;
  end
end

always_comb begin
  reaction_d = reaction_q;
  if(action_d) begin
    reaction_d = 1'b1;
  end else begin
    reaction_d = 1'b0;
  end
end

always_ff @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    action_q <= 1'b0;
    reaction_q <= 1'b0;
    state_q <= Idle;
  end else begin
    action_q <= action_d;
    reaction_q <= reaction_d;
    state_q <= state_d;
  end
end

logic [2:0] use_d,use_q;

assign use_d = (resp) ? use_q + 1 : use_q;

always_ff @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    use_q <= 'h0;
  end else begin
    use_q <= use_d;
  end
end*/

logic valid_d, valid_q;
logic ready_d, ready_q;

logic out;

logic wr;
logic rd;

assign out = rd;

int cnt_d, cnt_q;

logic [1 : 0] buff;

logic wr_pt_d, wr_pt_q;

int required_d, required_q;

assign wr = valid_q && (cnt_q < 2);
assign rd = ready_q && (cnt_q >= required_q);

always_ff @(posedge clk or negedge arst_n) begin
  if (wr) begin
    buff[wr_pt_q] = 1'b1;
  end
end

always_comb begin
  cnt_d = cnt_q;
  if (wr && ~rd) begin
    cnt_d = cnt_q + 1;
  end
  if (rd && ~wr) begin
    cnt_d = cnt_q - required_q;
  end
end

always_comb begin
  wr_pt_d = wr_pt_q;
  if (wr) begin
    wr_pt_d = wr_pt_q + 1;
  end
end

always_ff @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    wr_pt_q <= 'h0;
    cnt_q <= 'h0;
  end else begin
    wr_pt_q <= wr_pt_d;
    cnt_q <= cnt_d;
  end
end

initial begin 
buff[0] = 1'b0;
buff[1] = 1'b0;
#10;

valid_q = 1;
ready_q = 1;
required_q = 2;

#4;
valid_q = 0;

#2;

valid_q = 1;
ready_q = 1;
required_q = 1;

#2;
valid_q = 0;


end

endmodule