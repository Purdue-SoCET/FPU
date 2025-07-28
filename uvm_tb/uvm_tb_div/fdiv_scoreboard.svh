class fdiv_scoreboard extends uvm_component;
  `uvm_component_utils(fdiv_scoreboard)

  uvm_analysis_export#(float_div_txn)  in_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    in_export = new("in_export", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    float_div_txn txn;
    forever begin
      in_export.get(txn);
      real d = $bitstoreal(txn.dividend);
      real v = $bitstoreal(txn.divisor);
      real q = d/v;
      bit [31:0] golden = $realtobits(q);
      if (txn.expected !== golden) begin
        `uvm_error("FDIV_SCB", $sformatf("Mismatch: got %h expected %h", txn.expected, golden))
      end
    end
  endtask
endclass
