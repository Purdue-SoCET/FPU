class float_div_seq extends uvm_sequence #(float_div_txn);
  `uvm_object_utils(float_div_seq)

  rand int unsigned num_items;
  constraint c_num { num_items inside {[10:100]}; }

  function new(string name = "float_div_seq");
    super.new(name);
  endfunction

  virtual task body();
    float_div_txn txn;
    repeat (num_items) begin
      txn = float_div_txn::type_id::create("txn");
      assert(txn.randomize() with { divisor != 0; });
      txn.calculate_expected();
      start_item(txn);
      finish_item(txn);
    end
  endtask
endclass
