// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vadder.h for the primary calling header

#include "verilated.h"

#include "Vadder__Syms.h"
#include "Vadder___024root.h"

VL_ATTR_COLD void Vadder___024root___eval_static(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vadder___024root___eval_final(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vadder___024root___eval_triggers__stl(Vadder___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__stl(Vadder___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void Vadder___024root___eval_stl(Vadder___024root* vlSelf);

VL_ATTR_COLD void Vadder___024root___eval_settle(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        Vadder___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                Vadder___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("uvm_tb/uvm_tb_add_single/tb_adder.sv", 3, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            Vadder___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__stl(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void Vadder___024root___act_sequent__TOP__0(Vadder___024root* vlSelf);

VL_ATTR_COLD void Vadder___024root___eval_stl(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vadder___024root___act_sequent__TOP__0(vlSelf);
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__act(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__nba(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vadder___024root___ctor_var_reset(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->addertb__DOT__tb_data1 = VL_RAND_RESET_I(32);
    vlSelf->addertb__DOT__tb_data2 = VL_RAND_RESET_I(32);
    vlSelf->addertb__DOT__tb_result = VL_RAND_RESET_I(32);
    vlSelf->addertb__DOT__DUT__DOT__exp_sub = VL_RAND_RESET_I(8);
    vlSelf->addertb__DOT__DUT__DOT__biggerExp = VL_RAND_RESET_I(8);
    }
