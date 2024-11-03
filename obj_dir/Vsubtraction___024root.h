// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vsubtraction.h for the primary calling header

#ifndef VERILATED_VSUBTRACTION___024ROOT_H_
#define VERILATED_VSUBTRACTION___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vsubtraction__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vsubtraction___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*7:0*/ tb_sub__DOT__DUT__DOT__biggerEXP;
    CData/*7:0*/ tb_sub__DOT__DUT__DOT__exp_sub;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ tb_sub__DOT__tb_data1;
    IData/*31:0*/ tb_sub__DOT__tb_data2;
    IData/*31:0*/ tb_sub__DOT__tb_result;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vsubtraction__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vsubtraction___024root(Vsubtraction__Syms* symsp, const char* v__name);
    ~Vsubtraction___024root();
    VL_UNCOPYABLE(Vsubtraction___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
