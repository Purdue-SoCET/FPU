module tb_mult ();

    // logic declarations
    logic [31:0] tb_data1;
    logic [31:0] tb_data2;
    logic [31:0] tb_result;
    

    // Instantiate the multiplication module
    mult_diya DUT (.data1(tb_data1), .data2(tb_data2), .result(tb_result));

    task setinputs;
    input logic [31:0] data1tb;
    input logic [31:0] data2tb;
    begin
        tb_data1 = data1tb;
        tb_data2 = data2tb;
    end
    endtask

    initial begin
        $dumpfile("Multiplication_new_waveform.fst");
        $dumpvars(0, tb_mult);

       $display("Initializing data variables...");
       
        tb_data1 = '0;
        tb_data2 = '0;

        // POS x POS, result should be positive
       $display("Running first test case.");
       
        setinputs(32'b01000010110010000110011001100110, 32'b01000010101101010000000000000000); // 100.2 x 90.5
        #(10); // waits 10 ns
        if(tb_result != 32'b01000110000011011011000001100110) begin
            $display("ERROR [1]: Expected: 9068.1. Your output: %d", tb_result);
        end
       $display("Test case done!");
       
        // NEG x NEG, result should be positive
       $display("Running second test case.");
       
        setinputs(32'b11000000101011001100110011001101, 32'b11000001001011001100110011001101); // -5.4 x -10.8
        #(10);
        if(tb_result != 32'b01000010011010010100011110101111) begin
            $display("ERROR [2]: Expected: 58.320004. Your output: %d", tb_result);
        end
       $display("Test case done!");

        // POS x NEG, result should be negative
       $display("Running third test case.");
       
        setinputs(32'b01000000101011001100110011001101, 32'b11000001001011001100110011001101); // 5.4 x -10.8
        #(10);
        if(tb_result != 32'b11000010011010010100011110101111) begin;
            $display("ERROR [3]: Expected: -58.320004. Your output: %d", tb_result);
        end
       $display("Test case done!");

        // NEG x POS, result should be negative
       $display("Running fourth test case.");
       
        setinputs(32'b11000001001011001100110011001101, 32'b01000000101011001100110011001101); // -10.8 x 5.4
        #(10);
        if(tb_result != 32'b11000010011010010100011110101111) begin
            $display("ERROR [4]: Expected: -58.320004. Your output: %d", tb_result);
        end
       $display("Test case done!");
       
        // POS x NaN, result should be NaN
       $display("Running fifth test case.");
       
        setinputs(32'b01000000101011001100110011001101, 32'b11111111111111111111111111111111); // 5.4 x NaN
        #(10);
        if(tb_result != 32'b11111111111111111111111111111111) begin
            $display("ERROR [5]: Expected: NaN. Your output: %d", tb_result);
        end
       $display("Test case done!");

       
        $finish;
    end
endmodule
