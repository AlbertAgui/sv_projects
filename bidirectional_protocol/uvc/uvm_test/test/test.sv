`ifndef TEST_SV
`define TEST_SV

import top_uvm_pkg::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)

  env#(DATA_SIZE,CNFG) m_env;
  seq#(DATA_SIZE) m_seq;

  uvm_event_pool pool = uvm_event_pool::get_global_pool();
  uvm_event driver_resp = pool.get("driver_resp");

  function new(string name = "test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_env = env#(DATA_SIZE,CNFG)::type_id::create("m_env", this);
    m_seq = seq#(DATA_SIZE)::type_id::create("m_seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    int wait_driver_resp;
    phase.raise_objection(this);

    wait_driver_resp = 0;
    fork
      begin
        m_seq.start(m_env.agenta.m_sequencer);
      end
      begin
        forever begin
          driver_resp.wait_trigger;
          wait_driver_resp++;
        end
      end
    join_none
    
    wait(wait_driver_resp == SEQ_NUM)
    phase.drop_objection(this);

  endtask : run_phase

endclass : test

`endif