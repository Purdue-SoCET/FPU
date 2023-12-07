`ifndef FADD_MONITOR_SVH
`define  FADD_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_add_if.svh"
`include "uvm_fpu_pkg.vh"
import uvm_fpu_pkg::*;

class fadd_monitor extends uvm_monitor;
    `uvm_component_utils(fadd_monitor)

    virtual float_add_if #(.WIDTH(WIDTH)) vif;

    uvm_analysis_port #(transaction) result_ap;
    
    function new(string name, uvm_component parent = null);    
        super.new(name, parent);
        result_ap = new("result_ap",this);
        //`uvm_info("fadd_monitor","monitor construct",UVM_LOW);
    endfunction: new

    // Build Phase - Get handle to signals in the testbench
    virtual function void build_phase(uvm_phase phase);  
        if (!uvm_config_db#(virtual float_add_if#(.WIDTH(WIDTH)) )::get(this, "", "float_add_vif", vif)) begin
            `uvm_fatal("monitor", "No virtual interface specified for this monitor instance")
        end
        //`uvm_info("fadd_monitor","monitor build",UVM_LOW);
    endfunction

    virtual task run_phase(uvm_phase phase);
        //`uvm_info("fadd_monitor","monitor run",UVM_LOW);
        // Wait for clock to be active
        @(posedge vif.clk);
        
        // Start monitoring
        forever begin
            transaction txn;
            wait(vif.float1 !== 'x && vif.float2 !== 'x);
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

endclass: fadd_monitor
`endif