# 🧪 FPU FIFO UVM Testbench

This repository implements a **UVM (Universal Verification Methodology)** testbench for verifying the **FIFO Buffer** of the Floating Point Unit (FPU) project. The structure follows the provided verification architecture with agents, monitors, scoreboards, and randomized floating-point stimulus.

---

## 📂 Directory Structure

fpu_uvm_tb/
├── Makefile # Build & simulation automation
├── README.md # Documentation
├── fpu_uvm_pkg.sv # UVM package with all components
├── tb_top.sv # Top-level simulation module
├── fifo_buffer.sv # DUT (RTL FIFO)
├── interfaces/ # SystemVerilog interface
│ └── fifo_interface.sv
├── sequences/ # UVM sequences and items
│ ├── fifo_seq_item.sv
│ ├── fifo_seq.sv
│ ├── clk_seq_item.sv
│ └── clk_seq.sv
├── drivers/ # UVM drivers
│ ├── fifo_driver.sv
│ └── clk_driver.sv
├── monitors/ # UVM monitors
│ ├── fifo_monitor.sv
│ └── flag_monitor.sv
├── agents/ # UVM agents
│ ├── fifo_agent.sv
│ └── clk_agent.sv
├── scoreboards/ # UVM scoreboards
│ ├── data_scoreboard.sv
│ └── flag_scoreboard.sv
└── env/ # UVM environment
└── environment.sv


---

## 🚀 How to Build and Run

### 1. **Prerequisites**
- A simulator with UVM support (e.g., QuestaSim/ModelSim, Synopsys VCS, Cadence Xcelium)
- Ensure the UVM library is available (`uvm_pkg`)

### 2. **Compile the Testbench**
```bash
make compile
3. Run the Simulation
make run
This will:

Compile all SystemVerilog sources
Run the UVM test
Exit after completion
4. Clean Build Artifacts
make clean
🛠 Features

✅ UVM Agents for FIFO and Clock stimulus
✅ Scoreboards to validate data correctness and flag behavior
✅ Monitors to collect transactions and send them to analysis ports
✅ Randomized Floating-Point Stimulus
Generates special cases: NaN, +Inf, -Inf, Subnormal, and normal FP values
✅ Config DB Integration for seamless virtual interface sharing
✅ Makefile Automation for easy compilation & simulation
📌 How It Works

FIFO Agent: Drives random data and control signals to the DUT
Clock Agent: Generates clock and reset sequences
Monitors: Observe DUT signals and send transactions to scoreboards
Scoreboards: Compare observed results against expected outcomes
Environment: Instantiates and connects agents, monitors, and scoreboards
Test: Configures and launches the verification sequences
✅ Example Simulation Output

When running, you should see UVM logs like:

UVM_INFO @ 50ns: uvm_test_top.env.d_sb [DATA_SB] Checking data: FP DATA=3F800000 WRITE=1 READ=0
UVM_INFO @ 55ns: uvm_test_top.env.f_sb [FLAG_SB] Checking flag: FP DATA=7FC00000 WRITE=0 READ=0
🧩 Extending the Testbench

You can easily enhance this testbench by:

Adding functional coverage (e.g., cover special FP cases and FIFO depth usage)
Adding SystemVerilog Assertions (SVA) to check FIFO protocol correctness
Expanding sequences to include error injection and stress tests
👨‍💻 Author Notes

This UVM environment is designed to be modular and scalable.
Simply place your FIFO RTL (fifo_buffer.sv) in the project folder and run.
Modify fifo_seq.sv to create new test scenarios.
✅ Conclusion

With this setup, you have a ready-to-run UVM verification environment for your SoCET FPU FIFO.
Just build, run, and start enhancing it with coverage, assertions, and more verification scenarios!
