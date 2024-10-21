// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsubtraction.h for the primary calling header

#include "verilated.h"

#include "Vsubtraction__Syms.h"
#include "Vsubtraction__Syms.h"
#include "Vsubtraction___024root.h"

void Vsubtraction___024root___ctor_var_reset(Vsubtraction___024root* vlSelf);

Vsubtraction___024root::Vsubtraction___024root(Vsubtraction__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vsubtraction___024root___ctor_var_reset(this);
}

void Vsubtraction___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vsubtraction___024root::~Vsubtraction___024root() {
}
