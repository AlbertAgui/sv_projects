`ifndef SEQUENCER_SV
`define SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class sequencer extends uvm_sequencer#(seq_item);

  `uvm_sequencer_utils(sequencer)

  uvm_blocking_put_port #(seq_item) put_port;
     
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : sequencer

`endif