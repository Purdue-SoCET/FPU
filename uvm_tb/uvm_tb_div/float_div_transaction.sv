class float_div_txn extends uvm_sequence_item;
  `uvm_object_utils_begin(float_div_txn)
    `uvm_field_int(dividend, UVM_ALL_ON)
    `uvm_field_int(divisor,  UVM_ALL_ON)
    `uvm_field_int(expected, UVM_ALL_ON)
  `uvm_object_utils_end

  rand bit [31:0] dividend;
  rand bit [31:0] divisor;
  bit [31:0] expected;

  function void calculate_expected();
    real d = $bitstoreal(dividend);
    real v = $bitstoreal(divisor);
    real q = d / v;
    expected = $realtobits(q);
  endfunction

  function new(string name = "float_div_txn");
    super.new(name);
  endfunction
endclass
