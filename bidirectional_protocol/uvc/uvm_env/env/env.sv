`ifndef ENV_SV
`define ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class env#(
  parameter int DATA_SIZE =  16,
  parameter string CNFG = "READY_VALID"
) extends uvm_env;
  `uvm_component_utils(env #(DATA_SIZE,CNFG))
  agent#(DATA_SIZE,CNFG) agenta;

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agenta = agent#(DATA_SIZE,CNFG)::type_id::create("agenta", this);
  endfunction : build_phase

  // connect_phase
  function void connect_phase(uvm_phase phase);

  endfunction : connect_phase

endclass : env

`endif