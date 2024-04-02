module float_cvtHW(
    input  logic [31:0] int32,
    input  logic [2:0]  rounding_mode,
    output logic  [15:0] float16
);

    logic sign;
    logic [31:0] magnitude;
    logic [4:0] exponent;
    logic [9:0] mantissa;
    logic [10:0] extended_mantissa;
    
    always_comb begin
        // Extract sign bit
        sign = int32[31];

        // Absolute value (handling 2's complement)
        magnitude = sign ? (~int32 + 1) : int32;

        // Determine the position of the most significant bit (MSB)
        integer msb_pos;
        begin
            msb_pos = -1; // Default for zero
            for (int i = 30; i >= 0; i--) begin
                if (magnitude[i]) begin
                    msb_pos = i;
                    break;
                end
            end
        end

        // Handle zero separately
        if (msb_pos == -1) begin
            float16 = 0;
            return;
        end

        // Calculate exponent and mantissa

        // Bias for 5-bit exponent is 15
        integer raw_exponent = msb_pos + 15;

        // Rounding can affect both mantissa and exponent
        extended_mantissa = magnitude[msb_pos-1 -: 11]; // 11 bits for rounding

        // Apply rounding based on mode
        // Additional rounding logic needed here based on rounding_mode
        // ...

        // Adjust exponent and mantissa after rounding
        exponent = raw_exponent[4:0]; // Assuming no overflow/underflow for simplicity
        mantissa = extended_mantissa[9:0]; // Truncated to 10 bits
    end

    
    
    // Assemble the float16 value
    assign float16 = {sign, exponent, mantissa};

endmodule
