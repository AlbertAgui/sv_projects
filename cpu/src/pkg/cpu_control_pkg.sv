package cpu_control_pkg;
  localparam PIPELINE_STATE_NUM = 5;
  localparam PIPELINE_STATE_BITS = $clog2(PIPELINE_STATE_NUM);
  typedef enum logic[PIPELINE_STATE_BITS-1:0] { 
    fetch,
    decode,
    s_reg,
    alu,
    wb
  } pipeline_state_t;

  
endpackage