class fdiv_driver extends uvm_driver #(float_div_txn);
  `uvm_component_utils(fdiv_driver)

  virtual float_div_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual float_div_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set")
  endfunction

  virtual task run_phase(uvm_phase phase);
    float_div_txn txn;
    forever begin
      seq_item_port.get_next_item(txn);
      // drive operands
      vif.dividend <= txn.dividend;
      vif.divisor  <= txn.divisor;
      vif.valid    <= 1;
      @(posedge vif.clk);
      vif.valid    <= 0;
      // wait for done
      @(posedge vif.clk);
      wait (vif.done);
      // handshake complete
      seq_item_port.item_done();
    end
  endtask
endclass
