module mult_new (    
    input logic [31:0] data1, data2,
    output logic [31:0] result
);

    // Intermediate signals
    logic sign_data1, sign_data2, sign_result;
    logic [7:0] exp_data1, exp_data2, exp_sum, exp_result, exp_result_temp;
    logic [4:0] shift;
    logic [23:0] mant_data1, mant_data2;
    logic [47:0] mant_result;       //mantissas result (24 x 24 = 48 bits)
    logic [23:0] mant_normalized;
    logic [7:0] exp_adjusted;

    ///adder module
    logic [31:0] norm_input1, norm_input2, norm_result;
    logic norm_overflow, norm_underflow;

    adder adder (
        .data1(norm_input1),
        .data2(norm_input2),
        .result(norm_result),
        .overflow(norm_overflow),
        .underflow(norm_underflow)
    );

    //test signals
    logic zero, snan, qnan, inf, carry, no_carry, n_n, n_s, s_s;

    // Extract fields from inputs
    assign sign_data1 = data1[31];
    assign sign_data2 = data2[31];
    assign exp_data1 = data1[30:23];
    assign exp_data2 = data2[30:23];
    //adding implicit leading 1 with subnormal numbers in consideration
    assign mant_data1 = (exp_data1 == 0) ? {1'b0, data1[22:0]} : {1'b1, data1[22:0]}; 
    assign mant_data2 = (exp_data2 == 0) ? {1'b0, data2[22:0]} : {1'b1, data2[22:0]}; 

    assign result = {sign_result, exp_adjusted, mant_normalized[22:0]};

    always_comb begin
        /////////// Default ///////////
        exp_result = '0;
        exp_result_temp = '0;
        mant_result = '0;
        sign_result = '0;
        exp_sum = '0;
        mant_result = '0;
        //test signals
        zero = 0;
        snan = 0;
        qnan = 0;
        inf = 0;
        n_n = 0;
        n_s = 0;
        s_s = 0;
        shift = '0;

        /////////////NaN case//////////////
         if ((exp_data1 == '1 && mant_data1[22:0] == '1) || (exp_data2 == '1 && mant_data2[22:0] == '1) || (data1 == '0 && exp_data2 == '1 && mant_data2 == '0) || (data2 == '0 && exp_data1 == '1 && mant_data1 == '0)) begin
            //qnan
            qnan = 1;
            sign_result = '1;
            exp_result = '1;
            mant_result = '1;
         end else if ((exp_data1 == 8'b00000000 && ~mant_data1[22] && mant_data1 != '0) || (exp_data2 == 8'b00000000 && ~mant_data2[22] && mant_data2 != '0)) begin
            //snan
            snan = 1;
            exp_result = '1;
            mant_result = '1; // SNaN * num = QNaN
            sign_result = '1;
        
        //////////////zero case///////////////
         end else if ((data1 == '0 && ~(exp_data2 == 8'b00000001 && mant_data2 == '0)) || (data2 == '0 && ~(exp_data1 == 8'b00000001 && mant_data1 == '0)) || (data1 == 32'b10000000000000000000000000000000 && ~(exp_data2 == 8'b00000001 && mant_data2 == '0)) || (data2 == 32'b10000000000000000000000000000000 && ~(exp_data1 == 8'b00000001 && mant_data1 == '0))) begin
            zero = 1;
            exp_result = '0;
            mant_result = '0;
            sign_result = sign_data1 ^ sign_data2;

        /////////////////inifinity case/////////////////
         end else if ((exp_data1 == 8'b00000001 && mant_data1 == '0) || (exp_data2 == 8'b00000001 && mant_data2 == '0)) begin
            inf = 1;
            exp_result = '1;
            mant_result = '0;
            sign_result = sign_data1 ^ sign_data2;
         
        /////////////actual multiplications/////////////////
         end else begin 
            sign_result = sign_data1 ^ sign_data2;
            exp_sum = exp_data1 + exp_data2 - 8'd127; // Adjust bias
            mant_result = mant_data1 * mant_data2;

            if (exp_data1 == '0 && exp_data2 == '0) begin // sub * sub
                exp_result = '0;
                s_s = 1;
            end else if (exp_data1 != '0 && exp_data2 != '0) begin // norm * norm
                exp_result = exp_sum;
                exp_result_temp = ({2'b0, exp_data1} - 8'd127) + {2'b0, exp_data2};
                n_n = 1;
            end else begin // sub * norm or norm * sub
                n_s = 1;
                if (exp_data1 == '0) begin // data1 = sub
                    for (int i = 22; i >= 0; i = i - 1) begin
                        if (mant_data1[i] == 1'b1) begin
                            shift = i[4:0]; //Determine the leading 1 in mantissa
                            break;
                        end
                    end
                    exp_result = exp_data2 - (8'd127 - shift) + 8'd1; // Adjust the exponent for subnormal * normalized
                    exp_result_temp = {2'b0, exp_data2} - (8'd127 - shift) + 8'd1;
                    mant_result = {1'b1, mant_data1 << (8'd127 - shift)} * {1'b1, mant_data2}; // Align mantissas for multiplication
                end else if (exp_data2 == '0) begin // data2 = sub
                    for (int i = 22; i >= 0; i = i - 1) begin
                        if (mant_data2[i] == 1'b1) begin
                            shift = i[4:0]; // Determine the leading 1 in mantissa
                            break;
                        end
                    end
                    exp_result = exp_data1 - (8'd127 - shift) + 8'd1; // Adjust the exponent for normalized * subnormal
                    exp_result_temp = {2'b0, exp_data1} - (8'd127 - shift) + 8'd1;
                    mant_result = {1'b1, mant_data2 << (8'd127 - shift)} * {1'b1, mant_data1}; // Align mantissas for multiplication
                end
            end
        end
    end

    always_comb begin
        carry = 0;
        no_carry = 0;
        mant_normalized = '0;
        exp_adjusted = '0;
        norm_input1 = '0;
        norm_input2 = '0;

        //Normalize the mantissa
        if (mant_result[47]) begin
            carry = 1;
            mant_normalized = mant_result[46:23]; // No shift needed
            exp_adjusted = exp_result + 1;         // Increment exponent
        end else begin
            no_carry = 1;
            norm_input1 = {sign_result, exp_result, mant_result[46:23]}; // Use adder for shift
            norm_input2 = 32'b0; // Add zero to isolate normalization
            exp_adjusted = exp_result; // Let adder handle further adjustment
        end 
    end

endmodule