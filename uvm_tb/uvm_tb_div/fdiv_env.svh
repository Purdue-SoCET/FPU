class fdiv_env extends uvm_env;
  `uvm_component_utils(fdiv_env)

  fdiv_agent       agent;
  fdiv_scoreboard  sb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fdiv_agent::type_id::create("agent", this);
    sb    = fdiv_scoreboard::type_id::create("sb", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.ap.connect(sb.in_export);
  endfunction
endclass
