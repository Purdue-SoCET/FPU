// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VSUBTRACTION__SYMS_H_
#define VERILATED_VSUBTRACTION__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vsubtraction.h"

// INCLUDE MODULE CLASSES
#include "Vsubtraction___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vsubtraction__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vsubtraction* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vsubtraction___024root         TOP;

    // CONSTRUCTORS
    Vsubtraction__Syms(VerilatedContext* contextp, const char* namep, Vsubtraction* modelp);
    ~Vsubtraction__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
