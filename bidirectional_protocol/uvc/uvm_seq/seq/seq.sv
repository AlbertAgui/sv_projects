`ifndef SEQ_SV
`define SEQ_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq)

  int last_sum;
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
    last_sum = 0;
  endfunction
  
  virtual task body();
    int count = 10;
    seq_item m_seq_item;
    for(int i = 0; i < count; ++i) begin
      #10;
      m_seq_item = seq_item::type_id::create("m_seq_item");
      start_item(m_seq_item);
      m_seq_item.rdata = i[7:0];
      finish_item(m_seq_item);
    end
  endtask

endclass

`endif