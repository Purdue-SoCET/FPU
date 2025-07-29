package fpu_uvm_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Interfaces
    `include "fifo_interface.sv"

    // Sequence Items
    `include "fifo_seq_item.sv"
    `include "clk_seq_item.sv"

    // Sequences
    `include "fifo_seq.sv"
    `include "clk_seq.sv"

    // Drivers
    `include "fifo_driver.sv"
    `include "clk_driver.sv"

    // Monitors
    `include "fifo_monitor.sv"
    `include "flag_monitor.sv"

    // Scoreboards
    `include "data_scoreboard.sv"
    `include "flag_scoreboard.sv"

    // Agents
    `include "fifo_agent.sv"
