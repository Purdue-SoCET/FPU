# 🧪 FPU FIFO UVM Testbench

This repository implements a **UVM (Universal Verification Methodology)** testbench for verifying the **FIFO Buffer** of the Floating Point Unit (FPU) project.  
The structure follows the provided verification architecture with agents, monitors, scoreboards, and randomized floating-point stimulus.

---

## 🚀 How to Build and Run

### 1. **Prerequisites**
- A simulator with UVM support (e.g., **QuestaSim/ModelSim**, **Synopsys VCS**, **Cadence Xcelium**)
- Ensure the UVM library is available (`uvm_pkg`)

---

### 2. **Compile the Testbench**
```bash
make compile
```


### 3. **Run the Simulation**
```bash
make run
```

This will:

Compile all SystemVerilog sources
Run the UVM test
Exit after completion

### 4. **Clean Build Artifacts**
```bash
make clean
```

## 🛠 Features

✅ UVM Agents for FIFO and Clock stimulus
✅ Scoreboards to validate data correctness and flag behavior
✅ Monitors to collect transactions and send them to analysis ports
✅ Randomized Floating-Point Stimulus
     - Generates special cases: NaN, +Inf, -Inf, Subnormal, and normal FP values
✅ Config DB Integration for seamless virtual interface sharing
✅ Makefile Automation for easy compilation & simulation


## 📌 How It Works

1. FIFO Agent: Drives random data and control signals to the DUT
2. Clock Agent: Generates clock and reset sequences
3. Monitors: Observe DUT signals and send transactions to scoreboards
4. Scoreboards: Compare observed results against expected outcomes
5. Environment: Instantiates and connects agents, monitors, and scoreboards
6. Test: Configures and launches the verification sequences


## ✅ Example Simulation Output

When running, you should see UVM logs like:
```css
UVM_INFO @ 50ns: uvm_test_top.env.d_sb [DATA_SB] Checking data: FP DATA=3F800000 WRITE=1 READ=0
UVM_INFO @ 55ns: uvm_test_top.env.f_sb [FLAG_SB] Checking flag: FP DATA=7FC00000 WRITE=0 READ=0

```
