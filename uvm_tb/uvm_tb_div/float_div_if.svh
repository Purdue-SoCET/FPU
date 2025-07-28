interface float_div_if (
  input  logic clk, reset_n,
  output logic valid,          // indicates new operands
  output logic [31:0] dividend,
  output logic [31:0] divisor,
  input  logic ready,          // DUT ready to accept
  input  logic [31:0] result,  // quotient
  input  logic done            // result valid
);
  // Clocking blocks, modports, etc.
endinterface
