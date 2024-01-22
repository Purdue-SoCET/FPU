`ifndef FMULT_DRIVER_SVH
`define FMULT_DRIVER_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_mult_if.svh"
`include "uvm_fpu_pkg.vh"
import uvm_fpu_pkg::*;

class fmult_driver extends uvm_driver#(transaction);
  `uvm_component_utils(fmult_driver)

  virtual float_mult_if#(.WIDTH(WIDTH)) vif;

  // driver contructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    //`uvm_info("fmult_driver","driver construct",UVM_LOW);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // get interface from database
    if( !uvm_config_db#(virtual float_mult_if#(.WIDTH(WIDTH)))::get(this, "", "float_mult_vif", vif) ) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("fmult_driver", "No virtual interface specified for this test instance");
    end
    //`uvm_info("fmult_driver","driver build",UVM_LOW);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    transaction req_item;
    //`uvm_info("fmult_driver","driver run",UVM_LOW);
    // Reset DUT
    DUT_reset();
    //`uvm_info("fmult_driver","DUT reset",UVM_LOW);
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
    //`uvm_info("float_mult_driver","bfr vif clk",UVM_LOW);
    @(posedge vif.clk);
    //`uvm_info("float_mult_driver","aftr vif clk",UVM_LOW);
    vif.n_rst = 1;
    @(posedge vif.clk);
    vif.n_rst = 0;
    @(posedge vif.clk);
    vif.n_rst = 1;
  endtask
endclass
`endif
