class flag_monitor extends uvm_monitor;
    virtual fifo_interface vif;
    uvm_analysis_port #(fifo_seq_item) ap;

    `uvm_component_utils(flag_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface set for flag_monitor")
    endfunction

    task run_phase(uvm_phase phase);
        fifo_seq_item flag_item;
        forever begin
            @(posedge vif.clk);
            flag_item = fifo_seq_item::type_id::create("flag_item");
            flag_item.write = vif.full;
            flag_item.read  = vif.empty;
            ap.write(flag_item);
        end
    endtask
endclass
