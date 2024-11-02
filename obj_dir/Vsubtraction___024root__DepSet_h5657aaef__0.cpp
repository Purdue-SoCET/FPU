// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsubtraction.h for the primary calling header

#include "verilated.h"

#include "Vsubtraction__Syms.h"
#include "Vsubtraction___024root.h"

VlCoroutine Vsubtraction___024root___eval_initial__TOP__0(Vsubtraction___024root* vlSelf);

void Vsubtraction___024root___eval_initial(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_initial\n"); );
    // Body
    Vsubtraction___024root___eval_initial__TOP__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vsubtraction___024root___eval_initial__TOP__0(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_initial__TOP__0\n"); );
    // Init
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__1__data1tb;
    __Vtask_tb_sub__DOT__setinputs__1__data1tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__1__data2tb;
    __Vtask_tb_sub__DOT__setinputs__1__data2tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__2__data1tb;
    __Vtask_tb_sub__DOT__setinputs__2__data1tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__2__data2tb;
    __Vtask_tb_sub__DOT__setinputs__2__data2tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__3__data1tb;
    __Vtask_tb_sub__DOT__setinputs__3__data1tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__3__data2tb;
    __Vtask_tb_sub__DOT__setinputs__3__data2tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__4__data1tb;
    __Vtask_tb_sub__DOT__setinputs__4__data1tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__4__data2tb;
    __Vtask_tb_sub__DOT__setinputs__4__data2tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__5__data1tb;
    __Vtask_tb_sub__DOT__setinputs__5__data1tb = 0;
    IData/*31:0*/ __Vtask_tb_sub__DOT__setinputs__5__data2tb;
    __Vtask_tb_sub__DOT__setinputs__5__data2tb = 0;
    // Body
    vlSelf->tb_sub__DOT__tb_data1 = 0x42c86666U;
    vlSelf->tb_sub__DOT__tb_data2 = 0x42b50000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       29);
    if (VL_UNLIKELY((0x3fcccccdU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [1]: Expected: 9.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    __Vtask_tb_sub__DOT__setinputs__1__data2tb = 0x42c9999aU;
    __Vtask_tb_sub__DOT__setinputs__1__data1tb = 0x4249999aU;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__1__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__1__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       36);
    if (VL_UNLIKELY((0xc119999bU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [2]: Expected: -50.4. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    __Vtask_tb_sub__DOT__setinputs__2__data2tb = 0xc4163852U;
    __Vtask_tb_sub__DOT__setinputs__2__data1tb = 0xc2acfae1U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__2__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__2__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       43);
    if (VL_UNLIKELY((0x43a2fae1U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [3]: Expected: 514.39. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    __Vtask_tb_sub__DOT__setinputs__3__data2tb = 0xc376e666U;
    __Vtask_tb_sub__DOT__setinputs__3__data1tb = 0xc3f6e666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__3__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__3__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       50);
    if (VL_UNLIKELY((0xc319999aU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [4]: Expected: -246.9. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    __Vtask_tb_sub__DOT__setinputs__4__data2tb = 0xc2b50000U;
    __Vtask_tb_sub__DOT__setinputs__4__data1tb = 0x42c86666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__4__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__4__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       57);
    if (VL_UNLIKELY((0x433eb333U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [5]: Expected: 190.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    __Vtask_tb_sub__DOT__setinputs__5__data2tb = 0x42b50000U;
    __Vtask_tb_sub__DOT__setinputs__5__data1tb = 0xc2c86666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__5__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__5__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       64);
    if (VL_UNLIKELY((0xc33eb333U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [6]: Expected: -190.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_FINISH_MT("uvm_tb/uvm_tb_sub_single/tb_sub.sv", 69, "");
}

VL_INLINE_OPT void Vsubtraction___024root___act_sequent__TOP__0(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___act_sequent__TOP__0\n"); );
    // Init
    IData/*22:0*/ tb_sub__DOT__DUT__DOT__mant1;
    tb_sub__DOT__DUT__DOT__mant1 = 0;
    IData/*22:0*/ tb_sub__DOT__DUT__DOT__mant2;
    tb_sub__DOT__DUT__DOT__mant2 = 0;
    CData/*7:0*/ tb_sub__DOT__DUT__DOT__count;
    tb_sub__DOT__DUT__DOT__count = 0;
    // Body
    tb_sub__DOT__DUT__DOT__mant1 = 0U;
    tb_sub__DOT__DUT__DOT__mant2 = 0U;
    tb_sub__DOT__DUT__DOT__count = 0U;
    if (((0xffU & (((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                   >> 0x17U)) > (0xffU & (((IData)(1U) 
                                           + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                          >> 0x17U)))) {
        vlSelf->tb_sub__DOT__DUT__DOT__exp_sub = (0xffU 
                                                  & ((((IData)(1U) 
                                                       + 
                                                       (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                                      >> 0x17U) 
                                                     - 
                                                     (((IData)(1U) 
                                                       + 
                                                       (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                                      >> 0x17U)));
        if ((0U == (IData)(tb_sub__DOT__DUT__DOT__count))) {
            tb_sub__DOT__DUT__DOT__count = (0xffU & 
                                            ((IData)(1U) 
                                             + (IData)(tb_sub__DOT__DUT__DOT__count)));
            tb_sub__DOT__DUT__DOT__mant2 = (0x7fffffU 
                                            & (((IData)(1U) 
                                                + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                               << 1U));
        }
        vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP = 
            (0xffU & (((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                      >> 0x17U));
        while (((IData)(tb_sub__DOT__DUT__DOT__count) 
                < ((IData)(vlSelf->tb_sub__DOT__DUT__DOT__exp_sub) 
                   - (IData)(1U)))) {
            tb_sub__DOT__DUT__DOT__mant2 = (0x7fffffU 
                                            & ((IData)(1U) 
                                               + (~ vlSelf->tb_sub__DOT__tb_data2)));
            tb_sub__DOT__DUT__DOT__count = (0xffU & 
                                            ((IData)(1U) 
                                             + (IData)(tb_sub__DOT__DUT__DOT__count)));
        }
    } else {
        vlSelf->tb_sub__DOT__DUT__DOT__exp_sub = (0xffU 
                                                  & ((((IData)(1U) 
                                                       + 
                                                       (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                                      >> 0x17U) 
                                                     - 
                                                     (((IData)(1U) 
                                                       + 
                                                       (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                                      >> 0x17U)));
        if ((0U == (IData)(tb_sub__DOT__DUT__DOT__count))) {
            tb_sub__DOT__DUT__DOT__count = (0xffU & 
                                            ((IData)(1U) 
                                             + (IData)(tb_sub__DOT__DUT__DOT__count)));
            tb_sub__DOT__DUT__DOT__mant1 = (0x7fffffU 
                                            & (((IData)(1U) 
                                                + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                               << 1U));
        }
        vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP = 
            (0xffU & (((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                      >> 0x17U));
        while (((IData)(tb_sub__DOT__DUT__DOT__count) 
                < ((IData)(vlSelf->tb_sub__DOT__DUT__DOT__exp_sub) 
                   - (IData)(1U)))) {
            tb_sub__DOT__DUT__DOT__mant1 = (0x7fffffU 
                                            & ((IData)(1U) 
                                               + (~ vlSelf->tb_sub__DOT__tb_data1)));
            tb_sub__DOT__DUT__DOT__count = (0xffU & 
                                            ((IData)(1U) 
                                             + (IData)(tb_sub__DOT__DUT__DOT__count)));
        }
    }
    vlSelf->tb_sub__DOT__tb_result = ((((IData)(1U) 
                                        + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                       >> 0x1fU) ? 
                                      ((((IData)(1U) 
                                         + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                        >> 0x1fU) ? 
                                       (0x80000000U 
                                        | (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                            << 0x17U) 
                                           | (0x7fffffU 
                                              & (tb_sub__DOT__DUT__DOT__mant1 
                                                 + tb_sub__DOT__DUT__DOT__mant2))))
                                        : ((tb_sub__DOT__DUT__DOT__mant2 
                                            > tb_sub__DOT__DUT__DOT__mant1)
                                            ? (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                                << 0x17U) 
                                               | (0x7fffffU 
                                                  & (tb_sub__DOT__DUT__DOT__mant1 
                                                     - tb_sub__DOT__DUT__DOT__mant2)))
                                            : (0x80000000U 
                                               | (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                                   << 0x17U) 
                                                  | (0x7fffffU 
                                                     & (tb_sub__DOT__DUT__DOT__mant1 
                                                        + tb_sub__DOT__DUT__DOT__mant2))))))
                                       : ((((IData)(1U) 
                                            + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                           >> 0x1fU)
                                           ? ((tb_sub__DOT__DUT__DOT__mant1 
                                               > tb_sub__DOT__DUT__DOT__mant2)
                                               ? (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                                   << 0x17U) 
                                                  | (0x7fffffU 
                                                     & (tb_sub__DOT__DUT__DOT__mant1 
                                                        - tb_sub__DOT__DUT__DOT__mant2)))
                                               : (0x80000000U 
                                                  | (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                                      << 0x17U) 
                                                     | (0x7fffffU 
                                                        & (tb_sub__DOT__DUT__DOT__mant1 
                                                           - tb_sub__DOT__DUT__DOT__mant2)))))
                                           : (((IData)(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP) 
                                               << 0x17U) 
                                              | (0x7fffffU 
                                                 & (tb_sub__DOT__DUT__DOT__mant1 
                                                    + tb_sub__DOT__DUT__DOT__mant2)))));
}

void Vsubtraction___024root___eval_act(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vsubtraction___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vsubtraction___024root___eval_nba(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vsubtraction___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vsubtraction___024root___eval_triggers__act(Vsubtraction___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vsubtraction___024root___dump_triggers__act(Vsubtraction___024root* vlSelf);
#endif  // VL_DEBUG
void Vsubtraction___024root___timing_resume(Vsubtraction___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vsubtraction___024root___dump_triggers__nba(Vsubtraction___024root* vlSelf);
#endif  // VL_DEBUG

void Vsubtraction___024root___eval(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vsubtraction___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vsubtraction___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("uvm_tb/uvm_tb_sub_single/tb_sub.sv", 3, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Vsubtraction___024root___timing_resume(vlSelf);
                Vsubtraction___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vsubtraction___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("uvm_tb/uvm_tb_sub_single/tb_sub.sv", 3, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vsubtraction___024root___eval_nba(vlSelf);
        }
    }
}

void Vsubtraction___024root___timing_resume(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

#ifdef VL_DEBUG
void Vsubtraction___024root___eval_debug_assertions(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
