`ifndef FADD16_MONITOR_SVH
`define  FADD16_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_add_16bit_if.svh"

class fadd16_monitor extends uvm_monitor;
    `uvm_component_utils(fadd16_monitor)

    virtual float_add_16bit_if vif;

    uvm_analysis_port #(transaction) result_ap;
    
    function new(string name, uvm_component parent = null);    
        super.new(name, parent);
        result_ap = new("result_ap",this);
        //`uvm_info("fadd16_monitor","monitor construct",UVM_LOW);
    endfunction: new

    // Build Phase - Get handle to signals in the testbench
    virtual function void build_phase(uvm_phase phase);  
        if (!uvm_config_db#(virtual float_add_16bit_if)::get(this, "", "float_add_16bit_vif", vif)) begin
            `uvm_fatal("monitor", "No virtual interface specified for this monitor instance")
        end
        //`uvm_info("fadd16_monitor","monitor build",UVM_LOW);
    endfunction

    virtual task run_phase(uvm_phase phase);
        //`uvm_info("fadd16_monitor","monitor run",UVM_LOW);
        // Wait for clock to be active
        @(posedge vif.clk);
        
        // Start monitoring
        forever begin
            transaction txn;
            wait(vif.float1 !== 16'bx && vif.float2 !== 16'bx);
            @(posedge vif.clk);
            txn = transaction::type_id::create("txn");
            
            // Sample input signals
            txn.float1 = vif.float1;
            txn.float2 = vif.float2;

            // Sample output signals
            txn.sum = vif.sum;
        
            // Send transaction to scoreboard
            result_ap.write(txn);

            // // Wait for next cycle
            // @(posedge vif.clk);
        end
endtask

endclass: fadd16_monitor
`endif