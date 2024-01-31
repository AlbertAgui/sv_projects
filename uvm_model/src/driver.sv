`ifndef DRIVER_SV
`define DRIVER_SV

class driver extends uvm_driver #(ins_tx);
    `uvm_component_utils(driver)

    // Variable: m_cfg
    agent_cfg m_cfg;

    protocol_base_class m_protocol_class;

    // Variable: tx
    ins_tx tx;

    uvm_event_pool pool = uvm_event_pool::get_global_pool();
    uvm_event driver_ready = pool.get("driver_ready");
    //uvm_event rtl_ready = pool.get("rtl_ready");

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "build_phase start in driver", UVM_LOW)
        if (m_cfg == null) begin
            //`uvm_fatal("DRIVER", "Configuration of dut agent for driver was not correctly set")
        end
    endfunction : build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        m_protocol_class.begin_protocol();
    endfunction : end_of_elaboration_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            m_protocol_class.do_protocol();
            begin
                forever begin
                    
                    //`uvm_info(get_type_name(), $sformatf(" TT: have_infl_instr: %d have_pending_instr: %h", m_protocol_class.have_infl_instr(), m_protocol_class.have_pending_instr()), UVM_DEBUG)
                    //if (!m_protocol_class.have_infl_instr() && !m_protocol_class.have_pending_instr()) begin
                        m_protocol_class.wait_for_clk();

                        if (m_protocol_class.have_infl_instr()) begin
                            `uvm_info(get_type_name(), $sformatf("driver.sv: esperant trigger"), UVM_DEBUG)
                            //driver_ready.wait_trigger(); //wait for sync
                            `uvm_info(get_type_name(), $sformatf("driver.sv: trigger superat"), UVM_DEBUG)
                        end
                        else begin
                            seq_item_port.get_next_item(tx);
                            m_protocol_class.drive(tx);
                            seq_item_port.item_done();
                        end
                    //end
                    
                end
            end
            /*begin
                forever begin
                    //if(1) begin
                    if(!m_protocol_class.have_infl_instr()) begin
                        m_protocol_class.wait_for_clk();
                        driver_ready.trigger();
                        `uvm_info(get_type_name(), $sformatf("driver.sv driver ready"), UVM_DEBUG)
                    end
                end
            end*/
        join_none
    endtask : run_phase

endclass : driver

`endif
