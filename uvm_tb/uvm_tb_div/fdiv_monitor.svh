class fdiv_monitor extends uvm_monitor;
  `uvm_component_utils(fdiv_monitor)

  virtual float_div_if vif;
  uvm_analysis_port#(float_div_txn) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    float_div_txn txn;
    forever begin
      @(posedge vif.done);
      txn = float_div_txn::type_id::create("txn");
      txn.dividend = vif.dividend;
      txn.divisor  = vif.divisor;
      txn.expected = vif.result; // observed; scoreboard will check
      ap.write(txn);
    end
  endtask
endclass
