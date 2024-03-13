`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq_item #(
  parameter int DATA_SIZE =  16
) extends uvm_sequence_item;
  `uvm_object_utils(seq_item#(DATA_SIZE))
  
  //Analysis Information
  rand logic [DATA_SIZE-1:0] data;
  
  //Constructor
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
endclass

`endif