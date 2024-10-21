// 'timescale 1ns / 10ps

module subtb ();

    // logic declarations
    logic [31:0] tb_data1;
    logic [31:0] tb_data2;
    logic [31:0] tb_result;

    // Instantiate the subtractor module
    subtraction DUT (.data1(tb_data1), .data2(tb_data2), .result(tb_result));

    task setinputs;
    input logic [31:0] data1tb;
    input logic [31:0] data2tb;
    begin
        tb_data1 = data1tb;
        tb_data2 = data2tb;
    end
    endtask

    initial begin
        
        tb_data1 = '0;
        tb_data2 = '0;

        // POS - POS, result should be positive
        setinputs(32'b01000010110010000110011001100110, 32'b01000010101101010000000000000000); // 100.2 - 90.5
        #(10); // waits 10 ns
        if(tb_result != 32'b00111111110011001100110011001101) begin
            $display("ERROR [1]: Expected: 9.7. Your output: %b", tb_result);
        end

        // POS - POS, result should be negative
        setinputs(32'b01000010010010011001100110011010, 32'b01000010110010011001100110011010); // 50.4 - 100.8
        #(10);
        if(tb_result != 32'b11000001000110011001100110011011) begin
            $display("ERROR [2]: Expected: -50.4. Your output: %b", tb_result);
        end

        // NEG - NEG, result should be positive
        setinputs(32'b11000010101011001111101011100001, 32'b11000100000101100011100001010010); // -86.49 - -600.88
        #(10);
        if(tb_result != 32'b01000011101000101111101011100001) begin;
            $display("ERROR [3]: Expected: 514.39. Your output: %b", tb_result);
        end

        // NEG - NEG, result should be negative
        setinputs(32'b11000011111101101110011001100110, 32'b11000011011101101110011001100110); // -493.8 - -246.9
        #(10);
        if(tb_result != 32'b11000011000110011001100110011010) begin
            $display("ERROR [4]: Expected: -246.9. Your output: %b", tb_result);
        end

        // POS - NEG, result should be positive
        setinputs(32'b01000010110010000110011001100110, 32'b11000010101101010000000000000000); // 100.2 - -90.5
        #(10);
        if(tb_result != 32'b01000011001111101011001100110011) begin
            $display("ERROR [5]: Expected: 190.7. Your output: %b", tb_result);
        end

        // NEG - POS, result should be negative
        setinputs(32'b11000010110010000110011001100110, 32'b01000010101101010000000000000000); // -100.2 - 90.5
        #(10);
        if(tb_result != 32'b11000011001111101011001100110011) begin
            $display("ERROR [6]: Expected: -190.7. Your output: %b", tb_result);
        end

        $finish;
    end
endmodule
