module tb_top;
    import uvm_pkg::*;
    `include "environment.sv"
    // Include all other components here or use a package

    logic clk;
    logic rst;
    fifo_interface intf(clk, rst);

    // DUT instantiation
    fifo_buffer dut (
        .clk(clk),
        .rst(rst),
        .data_in(intf.data_in),
        .data_out(intf.data_out),
        .write_en(intf.write_en),
        .read_en(intf.read_en),
        .full(intf.full),
        .empty(intf.empty)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        run_test("tb_test");
    end
endmodule

class tb_test extends uvm_test;
    environment env;
    fifo_seq fseq;
    clk_seq cseq;

    `uvm_component_utils(tb_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = environment::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        fseq = fifo_seq::type_id::create("fseq");
        cseq = clk_seq::type_id::create("cseq");
        fseq.start(env.f_agent.seqr);
        cseq.start(env.c_agent.seqr);
        phase.drop_objection(this);
    endtask
endclass
