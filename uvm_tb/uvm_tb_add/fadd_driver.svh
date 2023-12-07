`ifndef FADD_DRIVER_SVH
`define FADD_DRIVER_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_add_if.svh"
`include "uvm_fpu_pkg.vh"
import uvm_fpu_pkg::*;

class fadd_driver extends uvm_driver#(transaction);
  `uvm_component_utils(fadd_driver)

  virtual float_add_if #(.WIDTH(WIDTH)) vif;

  // driver contructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    //`uvm_info("fadd_driver","driver construct",UVM_LOW);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // get interface from database
    if( !uvm_config_db#(virtual float_add_if#(.WIDTH(WIDTH)))::get(this, "", "float_add_vif", vif) ) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("fadd_driver", "No virtual interface specified for this test instance");
    end
    //`uvm_info("fadd_driver","driver build",UVM_LOW);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    transaction req_item;

    // Reset DUT
    DUT_reset();

    forever begin
        // Wait for a new transaction from the sequencer
        seq_item_port.get_next_item(req_item);
        // Drive the transaction onto the DUT "inputs"
        vif.float1 = req_item.float1;
        vif.float2 = req_item.float2;
        // Notify the sequencer that the transaction has been processed
        seq_item_port.item_done();
        end
  endtask

  task DUT_reset();

    @(posedge vif.clk);

    vif.n_rst = 1;
    @(posedge vif.clk);
    vif.n_rst = 0;
    @(posedge vif.clk);
    vif.n_rst = 1;
  endtask
endclass
`endif
