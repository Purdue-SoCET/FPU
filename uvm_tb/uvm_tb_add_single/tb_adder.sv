// 'timescale 1ns / 10ps

module addertb ();

    // localparam CLK_PERIOD = 10ns;

    // logic clk, n_rst;
    logic [31:0] tb_data1;
    logic [31:0] tb_data2;
    logic [31:0] tb_result;

    adder DUT (.data1(tb_data1), .data2(tb_data2), .result(tb_result));

    initial begin
        
        tb_data1 = '0;
        tb_data2 = '0;

        #(10); // waits 10 ns
        //POS POS no carry
        tb_data1 = 32'b01000010110010000110011001100110; // 100.2
        tb_data2 = 32'b01000010101101010000000000000000; // 90.5
        if(tb_result != 32'b01000011001111101011001100110011) begin
            $display("Wrong output, actual value 190.7");
        end

        
        #(10); // waits 10 ns
        //POS POS with carry
        tb_data1 = 32'b01000010010010011001100110011010; // 50.4
        tb_data2 = 32'b01000010110010011001100110011010; // 100.8
        if(tb_result != 32'b01000011000101110011001100110011) begin
            $display("Wrong output, actual value 151.2");
        end

        #(10); // waits 10 ns
        //NEG NEG no carry
        tb_data1 = 32'b11000010101011001111101011100001; // -86.49
        tb_data2 = 32'b11000100000101100011100001010010; // -600.88
        if(tb_result != 32'b11000100001010111101011110101110) begin
            $display("Wrong output, actual value -687.37");
        end


        #(10); // waits 10 ns
        //NEG NEG with carry
        tb_data1 = 32'b11000011111101101110011001100110; // -493.8
        tb_data2 = 32'b11000011011101101110011001100110; // -246.9
        if(tb_result != 32'b11000100001110010010110011001101) begin
            $display("Wrong output, actual value -740.7");
        end

        #(10); // waits 10 ns
        //POS NEG
        tb_data1 = 32'b01000010110010000110011001100110; // 100.2
        tb_data2 = 32'b11000010101101010000000000000000; // -90.5
        if(tb_result != 32'b01000001000110110011001100110011) begin
            $display("Wrong output, actual value 9.7");
        end

        #(10); // waits 10 ns
        //NEG POS
        tb_data1 = 32'b11000010110010000110011001100110; // -100.2
        tb_data2 = 32'b01000010101101010000000000000000; // 90.5
        if(tb_result != 32'b11000001000110110011001100110011) begin
            $display("Wrong output, actual value -9.7");
        end


        $finish;
    end
endmodule