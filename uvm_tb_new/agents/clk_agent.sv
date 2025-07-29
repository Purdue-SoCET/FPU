class clk_agent extends uvm_agent;
    clk_driver drv;
    clk_sequencer seqr;

    `uvm_component_utils(clk_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = clk_driver::type_id::create("drv", this);
        seqr = clk_sequencer::type_id::create("seqr", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass
