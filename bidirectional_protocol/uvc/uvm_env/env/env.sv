`ifndef ENV_SV
`define ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class env extends uvm_env;
  `uvm_component_utils(env)
  agent agenta;

  logic wr;

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agenta = agent::type_id::create("agenta", this);
  endfunction : build_phase

  // connect_phase
  function void connect_phase(uvm_phase phase);
    //if(!uvm_config_db #(virtual data_if)::get(this,"", "data_a_if", agenta.m_driver.m_data_if))
    //  `uvm_error(get_type_name(), "virtual interface not found")
  endfunction : connect_phase

endclass : env

`endif