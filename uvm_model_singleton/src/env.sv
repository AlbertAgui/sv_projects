`ifndef ENV_SV
`define ENV_SV

class env extends uvm_env;
  `uvm_component_utils(env)
  agent agenta;
  //agent agentb;

  logic wr;

  ka_mem_model #(64, 128) m_mem_model;
  ka_mem_model #(64, 256) u_mem_model;

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agenta = agent::type_id::create("agenta", this);
    //agentb = agent::type_id::create("agentb", this);
    m_mem_model = ka_mem_model #(64, 128)::create_instance();
    u_mem_model = ka_mem_model #(64, 256)::create_instance();
  endfunction : build_phase

  // connect_phase
  function void connect_phase(uvm_phase phase);
    /*if(!uvm_config_db #(virtual data_if)::get(this,"", "data_a_if", agenta.m_driver.m_data_if))
      `uvm_error(get_type_name(), "virtual interface not found")*/
    /*if(!uvm_config_db #(virtual data_if)::get(this,"", "data_b_if", agentb.m_driver.m_data_if))
      `uvm_error(get_type_name(), "virtual interface not found")*/
    //uvm_config_db #(logic)::set(null,"*", "wr", agentb.m_driver.wr);
  endfunction : connect_phase

endclass : env

`endif