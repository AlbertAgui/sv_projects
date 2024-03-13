`ifndef SEQ_SV
`define SEQ_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq #(
  parameter int DATA_SIZE =  16
) extends uvm_sequence#(seq_item#(DATA_SIZE));
  `uvm_object_utils(seq #(DATA_SIZE))

  //Constructor
  function new(string name = "seq");
    super.new(name);
  endfunction

  virtual task body();
    seq_item#(DATA_SIZE) m_seq_item;

    forever begin
      m_seq_item = seq_item#(DATA_SIZE)::type_id::create("m_seq_item");

      start_item(m_seq_item);
      if (!m_seq_item.randomize()) begin
        `uvm_fatal(get_type_name(), "Could not randomize request sequence")
      end
      finish_item(m_seq_item);
    end
  endtask

endclass

`endif