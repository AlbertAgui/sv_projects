`ifndef DRIVER_SV
`define DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver #(seq_item);
    `uvm_component_utils(driver)

    // Variable: tx
    seq_item tx;

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "build_phase start in driver", UVM_LOW)
    endfunction : build_phase

    function void drive(seq_item tx);
        `uvm_info(get_type_name(), $sformatf("DRIVING: %h", tx.rdata), UVM_LOW)
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            begin
                forever begin
                    seq_item_port.get_next_item(tx);
                    drive(tx);
                    seq_item_port.item_done();
                end
            end
        join_none
    endtask : run_phase

endclass : driver

`endif
