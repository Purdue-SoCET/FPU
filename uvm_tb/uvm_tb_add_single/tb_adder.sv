// 'timescale 1ns / 10ps

module tb_adder ();

    // localparam CLK_PERIOD = 10ns;

    // logic clk, n_rst;
    logic [31:0] tb_data1;
    logic [31:0] tb_data2;
    logic [31:0] tb_result;
    logic tb_underflow;
    logic tb_overflow;

    adder DUT (.data1(tb_data1), .data2(tb_data2), .result(tb_result), .overflow(tb_overflow), .underflow(tb_underflow));

    initial begin
        $dumpfile("Adder_waveform.fst");
        $dumpvars(0, tb_adder);
        
        tb_data1 = '0;
        tb_data2 = '0;

        //POS POS no carry
        tb_data1 = 32'b01000010110010000110011001100110; // 100.2
        tb_data2 = 32'b01000010101101010000000000000000; // 90.5
        #(10); // waits 10 ns
        if(tb_result != 32'b01000011001111101011001100110011) begin
            $display("Wrong output, actual value 190.7. Yours: %d", tb_result);
        end

        100.2            0 10000101 10010000110011001100110
        90.5             0 10000101 01101010000000000000000
        // 01000011001111101011001100110011 190.7


        //POS POS with carry
        tb_data1 = 32'b01000010010010011001100110011010; // 50.4
        tb_data2 = 32'b01000010110010011001100110011010; // 100.8
        #(10); // waits 10 ns
        if(tb_result != 32'b01000011000101110011001100110011) begin
            $display("Wrong output, actual value 151.2. Yours: %d", tb_result);
        end

       
        //NEG NEG no carry
        tb_data1 = 32'b11000010101011001111101011100001; // -86.49
        tb_data2 = 32'b11000100000101100011100001010010; // -600.88
        #(10); // waits 10 ns
        if(tb_result != 32'b11000100001010111101011110101110) begin	   
           $display("Wrong output, actual value -687.37. Yours: %d", tb_result);
        end


        //NEG NEG with carry
        tb_data1 = 32'b11000011111101101110011001100110; // -493.8
        tb_data2 = 32'b11000011011101101110011001100110; // -246.9
        #(10); // waits 10 ns
        if(tb_result != 32'b11000100001110010010110011001101) begin
            $display("Wrong output, actual value -740.7. Yours: %d", tb_result);
        end


        tb_data1 = 32'b01000011000101100011001100110011; // 150.2
        tb_data2 = 32'b11000001111101000000000000000000; // -30.5
        #(10); // waits 10 ns
        if(tb_result != 32'b01000010111011110110011001100110) begin
            $display("Wrong output, actual value 119.7. Yours: %d", tb_result);
        end    

        //01000010111011110110011001100110 - 119.7
        //01000011011101111011001100110011 - 247.7


        //POS NEG
        tb_data1 = 32'b01000010110010000110011001100110; // 100.2
        tb_data2 = 32'b11000010101101010000000000000000; // -90.5
        #(10); // waits 10 ns
        if(tb_result != 32'b01000001000110110011001100110011) begin
            $display("Wrong output, actual value 9.7. Yours: %d", tb_result);
        end

//   0   10000101  110010000110011001100110   shift 1
//   1   10000101  101101010000000000000000   shift 2           biggerExp = 10000101

//       00000000  

    //  01000011000010011011001100110011   137.7
    //  01000001110011011001100110011000    25.7
    //  01000001000110110011001100110011    9.7
    //  01000001010011011001100110011000   12.85
       
        //NEG POS
        tb_data1 = 32'b11000010110010000110011001100110; // -100.2
        tb_data2 = 32'b01000010101101010000000000000000; // 90.5
        #(10); // waits 10 ns
        if(tb_result != 32'b11000001000110110011001100110011) begin
            $display("Wrong output, actual value -9.7. Yours: %d", tb_result);
        end
       

        $finish;
    end
endmodule
