`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_cvtHW(
    input  logic [31:0] int32,
    input  logic [2:0]  rm,
    output logic  [15:0] float16
);

    logic sign;
    logic [31:0] magnitude;
    logic [4:0] exponent;
    logic [9:0] mantissa;
    logic [10:0] extended_mantissa;

    logic [31:0] msb_pos;
    logic [31:0] raw_exponent;
    
    always_comb begin
        // Init
        sign = '0;
        magnitude = '0;
        exponent = '0;
        mantissa = '0;
        extended_mantissa = '0;
        msb_pos = '0;
        raw_exponent = '0;

        // Handle zero separately
        if (int32 == '0) begin
            float16 = 0;
        end else if (rm == '0 && $signed(int32) > 65519) begin
            float16 = HALF_INF;
        end else if (rm == '0 && $signed(int32) < -65519) begin
            float16 = HALF_INFN;
        end else begin
            // Extract sign bit
            sign = int32[31];
            // Absolute value (handling 2's complement)
            magnitude = sign ? (~int32 + 1) : int32;

            // Determine the position of the most significant bit (MSB)
            msb_pos = -1; // Default for zero
            for (int i = 30; i >= 0; i--) begin
                if (magnitude[i]) begin
                    msb_pos = i;
                    break;
                end
            end
            // Calculate exponent and mantissa

            // Bias for 5-bit exponent is 15
            raw_exponent = msb_pos + 15;

            // Rounding can affect both mantissa and exponent
            extended_mantissa = magnitude[msb_pos-1 -: 11]; // 11 bits for rounding

            // Apply rounding based on mode
            // Additional rounding logic needed here based on rounding_mode
            // ...
            casez (rm)
                RM_RMM: begin // tie to max
                    if (extended_mantissa[0]) begin
                        if (extended_mantissa == '1) begin
                            raw_exponent += 1;
                        end
                        extended_mantissa += 1;
                    end
                end

                RM_RNE: begin
                    if (extended_mantissa[0]) begin  //tie to even
                        if (magnitude[msb_pos-11 -: 2] == '0) begin //tie
                            if (extended_mantissa[1]) begin // even
                                extended_mantissa += 1;
                            end
                        end else begin //not tie
                            if (extended_mantissa == '1) begin
                                raw_exponent += 1;
                            end
                            extended_mantissa += 1;
                        end
                    end
                end

                RM_RUP: begin //round up
                    if (magnitude[msb_pos-11 -: 2] != '0) begin
                        if (extended_mantissa == '1) begin
                            raw_exponent += 1;
                        end
                        extended_mantissa += 1;
                    end
                end

                RM_RDN: begin // round down
                    if (sign) begin
                        if (magnitude[msb_pos-11 -: 2] != '0) begin
                            if (extended_mantissa == '1) begin
                                raw_exponent += 1;
                            end
                            extended_mantissa += 1;
                        end
                    end
                end

                default: begin 
                    //default is round to zero
                    //no operation is needed
                end
            endcase 
                

            // Adjust exponent and mantissa after rounding
            exponent = raw_exponent[4:0]; // Assuming no overflow/underflow for simplicity
            mantissa = extended_mantissa[9:0]; // Truncated to 10 bits

            // Assemble the float16 value
            if (raw_exponent > 31) begin
                float16 = sign ? HALF_INFN: HALF_INF;
            end else begin
                float16 = {sign, exponent, mantissa};
            end
            
        end
        
    end

endmodule
