class environment extends uvm_env;
    fifo_agent f_agent;
    clk_agent c_agent;
    data_scoreboard d_sb;
    flag_scoreboard f_sb;
    flag_monitor f_mon;

    `uvm_component_utils(environment)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        f_agent = fifo_agent::type_id::create("f_agent", this);
        c_agent = clk_agent::type_id::create("c_agent", this);
        d_sb = data_scoreboard::type_id::create("d_sb", this);
        f_sb = flag_scoreboard::type_id::create("f_sb", this);
        f_mon = flag_monitor::type_id::create("f_mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        f_mon.ap.connect(d_sb.imp);
        f_mon.ap.connect(f_sb.imp);
    endfunction
endclass
