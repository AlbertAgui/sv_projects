package fetch_pkg;
  import isa_pkg::*;

  //..fetch
  localparam FETCH_STATE_NUM = 3;
  localparam FETCH_STATE_BITS = $clog2(FETCH_STATE_NUM);
  typedef enum logic[FETCH_STATE_BITS-1:0] {
    fetch_nope,
    fetch_keep,
    fetch_next
  } fetch_state_t;

  typedef struct packed {
    fetch_state_t state;
  } fetch_req_t;

  typedef struct packed {
    logic valid;
    instruction_t raw_instruction;
  } fetch_to_decoder_info_t;
  //..end fetch

  //..wb_to_fetch
  typedef struct packed {
    logic take_branch
    imm_t branch_value;
  } wb_to_fetch_req_t;
  //..end wb_to_fetch

endpackage
