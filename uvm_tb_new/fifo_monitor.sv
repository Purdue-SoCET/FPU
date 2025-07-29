class fifo_monitor extends uvm_monitor;
    virtual fifo_interface vif;
    uvm_analysis_port #(fifo_seq_item) ap;

    `uvm_component_utils(fifo_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        fifo_seq_item item;
        forever begin
            @(posedge vif.clk);
            item = fifo_seq_item::type_id::create("mon_item");
            item.data  = vif.data_out;
            item.write = vif.write_en;
            item.read  = vif.read_en;
            ap.write(item);
        end
    endtask
endclass
