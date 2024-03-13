`ifndef DRIVER_SV
`define DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class driver #(
  parameter int DATA_SIZE =  16,
  parameter string CNFG = "READY_VALID"
) extends uvm_driver #(seq_item #(DATA_SIZE));
    `uvm_component_utils(driver #(DATA_SIZE, CNFG))

    local virtual req_resp_if#(DATA_SIZE, CNFG) m_req_resp_if;

    seq_item#(16) m_seq_item;
    logic [DATA_SIZE-1:0] resp_data;

    uvm_event_pool pool = uvm_event_pool::get_global_pool();
    uvm_event driver_resp = pool.get("driver_resp");

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "build_phase start in driver", UVM_LOW)
        
        if(!uvm_config_db#(virtual req_resp_if#(DATA_SIZE, CNFG))::get(this, "", "req_resp_if", m_req_resp_if))
        `uvm_fatal(get_type_name(),"req_resp_if set failed!")
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        fork
            begin
                forever begin
                    seq_item_port.get_next_item(m_seq_item);
                    m_req_resp_if.drive_req(m_seq_item.data);
                    seq_item_port.item_done();
                    `uvm_info(get_type_name(), $sformatf("request send, data: %h", m_seq_item.data), UVM_LOW)
                end
            end
            
            begin
                forever begin
                    m_req_resp_if.get_resp(resp_data);
                    `uvm_info(get_type_name(), $sformatf("response received, data: %h", resp_data), UVM_LOW)
                    driver_resp.trigger();
                end
            end
        join
    endtask : run_phase

endclass : driver

`endif
