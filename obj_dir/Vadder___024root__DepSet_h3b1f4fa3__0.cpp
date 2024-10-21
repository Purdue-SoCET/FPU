// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vadder.h for the primary calling header

#include "verilated.h"

#include "Vadder__Syms.h"
#include "Vadder___024root.h"

VlCoroutine Vadder___024root___eval_initial__TOP__0(Vadder___024root* vlSelf);

void Vadder___024root___eval_initial(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_initial\n"); );
    // Body
    Vadder___024root___eval_initial__TOP__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vadder___024root___eval_initial__TOP__0(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_initial__TOP__0\n"); );
    // Body
    vlSelf->addertb__DOT__tb_data1 = 0U;
    vlSelf->addertb__DOT__tb_data2 = 0U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       19);
    vlSelf->addertb__DOT__tb_data1 = 0x42c86666U;
    vlSelf->addertb__DOT__tb_data2 = 0x42b50000U;
    if (VL_UNLIKELY((0x433eb333U != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value 190.7\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       28);
    vlSelf->addertb__DOT__tb_data1 = 0x4249999aU;
    vlSelf->addertb__DOT__tb_data2 = 0x42c9999aU;
    if (VL_UNLIKELY((0x43173333U != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value 151.2\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       36);
    vlSelf->addertb__DOT__tb_data1 = 0xc2acfae1U;
    vlSelf->addertb__DOT__tb_data2 = 0xc4163852U;
    if (VL_UNLIKELY((0xc42bd7aeU != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value -687.37\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       45);
    vlSelf->addertb__DOT__tb_data1 = 0xc3f6e666U;
    vlSelf->addertb__DOT__tb_data2 = 0xc376e666U;
    if (VL_UNLIKELY((0xc4392ccdU != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value -740.7\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       53);
    vlSelf->addertb__DOT__tb_data1 = 0x42c86666U;
    vlSelf->addertb__DOT__tb_data2 = 0xc2b50000U;
    if (VL_UNLIKELY((0x411b3333U != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value 9.7\n");
    }
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       61);
    vlSelf->addertb__DOT__tb_data1 = 0xc2c86666U;
    vlSelf->addertb__DOT__tb_data2 = 0x42b50000U;
    if (VL_UNLIKELY((0xc11b3333U != vlSelf->addertb__DOT__tb_result))) {
        VL_WRITEF("Wrong output, actual value -9.7\n");
    }
    VL_FINISH_MT("uvm_tb/uvm_tb_add_single/tb_adder.sv", 70, "");
}

VL_INLINE_OPT void Vadder___024root___act_sequent__TOP__0(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___act_sequent__TOP__0\n"); );
    // Init
    IData/*22:0*/ addertb__DOT__DUT__DOT__mant1;
    addertb__DOT__DUT__DOT__mant1 = 0;
    IData/*22:0*/ addertb__DOT__DUT__DOT__mant2;
    addertb__DOT__DUT__DOT__mant2 = 0;
    CData/*7:0*/ addertb__DOT__DUT__DOT__count;
    addertb__DOT__DUT__DOT__count = 0;
    // Body
    addertb__DOT__DUT__DOT__mant1 = 0U;
    addertb__DOT__DUT__DOT__mant2 = 0U;
    addertb__DOT__DUT__DOT__count = 0U;
    if (((0xffU & (vlSelf->addertb__DOT__tb_data1 >> 0x17U)) 
         > (0xffU & (vlSelf->addertb__DOT__tb_data2 
                     >> 0x17U)))) {
        vlSelf->addertb__DOT__DUT__DOT__exp_sub = (0xffU 
                                                   & ((vlSelf->addertb__DOT__tb_data1 
                                                       >> 0x17U) 
                                                      - 
                                                      (vlSelf->addertb__DOT__tb_data2 
                                                       >> 0x17U)));
        if ((0U == (IData)(addertb__DOT__DUT__DOT__count))) {
            addertb__DOT__DUT__DOT__count = (0xffU 
                                             & ((IData)(1U) 
                                                + (IData)(addertb__DOT__DUT__DOT__count)));
            addertb__DOT__DUT__DOT__mant2 = (0x7fffffU 
                                             & (vlSelf->addertb__DOT__tb_data2 
                                                << 1U));
        }
        vlSelf->addertb__DOT__DUT__DOT__biggerExp = 
            (0xffU & (vlSelf->addertb__DOT__tb_data1 
                      >> 0x17U));
        while (((IData)(addertb__DOT__DUT__DOT__count) 
                < ((IData)(vlSelf->addertb__DOT__DUT__DOT__exp_sub) 
                   - (IData)(1U)))) {
            addertb__DOT__DUT__DOT__mant2 = (0x7fffffU 
                                             & vlSelf->addertb__DOT__tb_data2);
            addertb__DOT__DUT__DOT__count = (0xffU 
                                             & ((IData)(1U) 
                                                + (IData)(addertb__DOT__DUT__DOT__count)));
        }
    } else {
        vlSelf->addertb__DOT__DUT__DOT__exp_sub = (0xffU 
                                                   & ((vlSelf->addertb__DOT__tb_data2 
                                                       >> 0x17U) 
                                                      - 
                                                      (vlSelf->addertb__DOT__tb_data1 
                                                       >> 0x17U)));
        if ((0U == (IData)(addertb__DOT__DUT__DOT__count))) {
            addertb__DOT__DUT__DOT__count = (0xffU 
                                             & ((IData)(1U) 
                                                + (IData)(addertb__DOT__DUT__DOT__count)));
            addertb__DOT__DUT__DOT__mant1 = (0x7fffffU 
                                             & (vlSelf->addertb__DOT__tb_data1 
                                                << 1U));
        }
        vlSelf->addertb__DOT__DUT__DOT__biggerExp = 
            (0xffU & (vlSelf->addertb__DOT__tb_data2 
                      >> 0x17U));
        while (((IData)(addertb__DOT__DUT__DOT__count) 
                < ((IData)(vlSelf->addertb__DOT__DUT__DOT__exp_sub) 
                   - (IData)(1U)))) {
            addertb__DOT__DUT__DOT__mant1 = (0x7fffffU 
                                             & vlSelf->addertb__DOT__tb_data1);
            addertb__DOT__DUT__DOT__count = (0xffU 
                                             & ((IData)(1U) 
                                                + (IData)(addertb__DOT__DUT__DOT__count)));
        }
    }
    vlSelf->addertb__DOT__tb_result = ((vlSelf->addertb__DOT__tb_data1 
                                        >> 0x1fU) ? 
                                       ((vlSelf->addertb__DOT__tb_data2 
                                         >> 0x1fU) ? 
                                        (0x80000000U 
                                         | (((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                             << 0x17U) 
                                            | (0x7fffffU 
                                               & (addertb__DOT__DUT__DOT__mant1 
                                                  + addertb__DOT__DUT__DOT__mant2))))
                                         : ((addertb__DOT__DUT__DOT__mant2 
                                             > addertb__DOT__DUT__DOT__mant1)
                                             ? (((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                                 << 0x17U) 
                                                | (0x7fffffU 
                                                   & (addertb__DOT__DUT__DOT__mant1 
                                                      + addertb__DOT__DUT__DOT__mant2)))
                                             : (0x80000000U 
                                                | (((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & (addertb__DOT__DUT__DOT__mant1 
                                                         + addertb__DOT__DUT__DOT__mant2))))))
                                        : ((vlSelf->addertb__DOT__tb_data2 
                                            >> 0x1fU)
                                            ? ((addertb__DOT__DUT__DOT__mant1 
                                                > addertb__DOT__DUT__DOT__mant2)
                                                ? (
                                                   ((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & (addertb__DOT__DUT__DOT__mant1 
                                                         - addertb__DOT__DUT__DOT__mant2)))
                                                : (0x80000000U 
                                                   | (((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                                       << 0x17U) 
                                                      | (0x7fffffU 
                                                         & (addertb__DOT__DUT__DOT__mant1 
                                                            - addertb__DOT__DUT__DOT__mant2)))))
                                            : (((IData)(vlSelf->addertb__DOT__DUT__DOT__biggerExp) 
                                                << 0x17U) 
                                               | (0x7fffffU 
                                                  & (addertb__DOT__DUT__DOT__mant1 
                                                     + addertb__DOT__DUT__DOT__mant2)))));
}

void Vadder___024root___eval_act(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vadder___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vadder___024root___eval_nba(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vadder___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vadder___024root___eval_triggers__act(Vadder___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__act(Vadder___024root* vlSelf);
#endif  // VL_DEBUG
void Vadder___024root___timing_resume(Vadder___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__nba(Vadder___024root* vlSelf);
#endif  // VL_DEBUG

void Vadder___024root___eval(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval\n"); );
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
            Vadder___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vadder___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("uvm_tb/uvm_tb_add_single/tb_adder.sv", 3, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Vadder___024root___timing_resume(vlSelf);
                Vadder___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vadder___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("uvm_tb/uvm_tb_add_single/tb_adder.sv", 3, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vadder___024root___eval_nba(vlSelf);
        }
    }
}

void Vadder___024root___timing_resume(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

#ifdef VL_DEBUG
void Vadder___024root___eval_debug_assertions(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
