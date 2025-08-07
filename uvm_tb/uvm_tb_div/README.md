# Floating-Point Divider Verification (UVM)

A **Universal Verification Methodology (UVM)** testbench for a 16-bit IEEE-754 floating-point **divider**.  
The bench drives the RTL with constrained-random stimuli, checks results via a DPI-C golden model, and collects functional coverage.

---
##  Quick start

```bash
# clean → build → run (batch mode)
# run from root directory Makefile
make div_uvm
```

* Console prints scoreboard **PASS / FAIL**  
* Functional coverage saved to **coverage.ucdb**

---


## Running specific tests

Run any test ad-hoc:

```bash
make run TESTNAME=underflow_div_test
```

---

## Clean

```bash
make clean
```

Deletes **work/**, logs, `.wlf`, `.ucdb`, and `dpi_lib.so`.


