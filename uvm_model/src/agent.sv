`ifndef AGENT_SV
`define AGENT_SV

`include "driver.sv"

class agent extends uvm_agent;
  // UVM automation macros for general components
  `uvm_component_utils(agent)

  //declaring agent components
  driver    m_driver;
  sequencer m_sequencer;

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(get_is_active() == UVM_ACTIVE) begin
      m_driver = driver::type_id::create("m_driver", this);
      m_sequencer = sequencer::type_id::create("m_sequencer", this);
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