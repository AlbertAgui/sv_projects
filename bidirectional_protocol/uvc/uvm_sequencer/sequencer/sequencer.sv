`ifndef SEQUENCER_SV
`define SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class sequencer #(
  parameter int DATA_SIZE =  16
) extends uvm_sequencer #(seq_item#(DATA_SIZE));
  `uvm_sequencer_utils(sequencer#(DATA_SIZE))

  uvm_blocking_put_port #(seq_item#(DATA_SIZE)) put_port;
     
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : sequencer

`endif