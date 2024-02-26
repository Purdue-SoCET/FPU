# SoCET_Half_Precision_FPU
SystemVerilog implementation of half precision floating point unit

## Useful links

- [IEEE 754 Calculator](http://weitz.de/ieee/)
- [IEEE 754 Float Toy](https://evanw.github.io/float-toy/)

## Module status

Multiplication: 
  - Functional for most numbers I've checked by hand (Including infinities, qNans/sNans, and sub-normals).
    - Current testing is plugging numbers in by hand so have only tested ~10 of each type
  - Khoi is writing testbench so that we can finalize module.

Addition:
  - Possibly done
  - Need to confirm weird edge cases (Inf + NaN, etc)

Subtraction: N/A

Rounding: N/A

TODO:
  - RISCV Business repository
    - Make a folder in there and put this code there
  - Allow the user to choose the rounding mode
  - Add inputs which accrues flags
    - Things like divide by zero, or other exceptions