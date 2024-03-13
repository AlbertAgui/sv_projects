`ifndef AGENT_SV
`define AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class agent#(
  parameter int DATA_SIZE =  16,
  parameter string CNFG = "READY_VALID"
) extends uvm_agent;
  // UVM automation macros for general components
  `uvm_component_utils(agent #(DATA_SIZE,CNFG))

  //declaring agent components
  driver#(DATA_SIZE,CNFG)    m_driver;
  sequencer#(DATA_SIZE) m_sequencer;

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(get_is_active() == UVM_ACTIVE) begin
      m_driver = driver#(DATA_SIZE,CNFG)::type_id::create("m_driver", this);
      m_sequencer = sequencer#(DATA_SIZE)::type_id::create("m_sequencer", this);
    end
  endfunction : build_phase

  // connect_phase
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : agent

`endif
