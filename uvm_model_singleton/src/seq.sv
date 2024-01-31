`ifndef SEQ_SV
`define SEQ_SV

import utils_pkg::*;

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq)

  int last_sum;
  transaction_cnt_wrapper transaction;
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
    last_sum = 0;
    transaction = new();
    uvm_config_db #(transaction_cnt_wrapper)::set(null, "*", "transaction", transaction);
  endfunction
  
  virtual task body();
    int count = 10;
    seq_item m_seq_item;
    for(int i = 0; i < count; ++i) begin
      #10;
      m_seq_item = seq_item::type_id::create("m_seq_item");
      transaction.cnt++;
      start_item(m_seq_item);
      m_seq_item.rdata = i[7:0];
      finish_item(m_seq_item);
    end
  endtask

  /*function int get_next_seqr_target();
    if(sum_object_add(0, 1)) begin
      last_sum = sum_object_getSum();
      if((last_sum % 2) == 0) begin
        return 0;
      end else
      begin
        return 1;
      end
    end
    return -1;
  endfunction : get_next_seqr_target*/
endclass

`endif