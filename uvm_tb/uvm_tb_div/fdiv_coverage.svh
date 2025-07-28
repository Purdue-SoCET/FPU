covergroup cg_div @(posedge vif.clk);
  option.per_instance = 1;
  coverpoint txn.dividend binsof(dividend_class);
  coverpoint txn.divisor  binsof(divisor_class);
  coverpoint txn.expected[31] iff(done); // sign bit coverage
endgroup
