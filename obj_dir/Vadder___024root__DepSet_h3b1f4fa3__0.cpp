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
    vlSelf->__Vm_traceActivity[1U] = 1U;
    Vadder___024root___eval_initial__TOP__0(vlSelf);
}

VL_INLINE_OPT void Vadder___024root___act_sequent__TOP__0(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___act_sequent__TOP__0\n"); );
    // Init
    CData/*0:0*/ tb_adder__DOT__DUT__DOT____VdfgExtracted_h836e9fe6__0;
    tb_adder__DOT__DUT__DOT____VdfgExtracted_h836e9fe6__0 = 0;
    // Body
    vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0 
        = ((vlSelf->tb_adder__DOT__tb_data1 >> 0x1fU) 
           == (vlSelf->tb_adder__DOT__tb_data2 >> 0x1fU));
    tb_adder__DOT__DUT__DOT____VdfgExtracted_h836e9fe6__0 
        = ((0xffU & (vlSelf->tb_adder__DOT__tb_data1 
                     >> 0x17U)) > (0xffU & (vlSelf->tb_adder__DOT__tb_data2 
                                            >> 0x17U)));
    if (tb_adder__DOT__DUT__DOT____VdfgExtracted_h836e9fe6__0) {
        vlSelf->tb_adder__DOT__DUT__DOT__biggerExp 
            = (0xffU & (vlSelf->tb_adder__DOT__tb_data1 
                        >> 0x17U));
        vlSelf->tb_adder__DOT__DUT__DOT__exp_sub = 
            (0xffU & ((IData)(1U) + ((~ (vlSelf->tb_adder__DOT__tb_data2 
                                         >> 0x17U)) 
                                     + (vlSelf->tb_adder__DOT__tb_data1 
                                        >> 0x17U))));
        vlSelf->tb_adder__DOT__DUT__DOT__shift1 = (0x800000U 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__tb_data1));
        vlSelf->tb_adder__DOT__DUT__DOT__shift2 = (
                                                   (0x17U 
                                                    >= (IData)(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub))
                                                    ? 
                                                   (0xffffffU 
                                                    & ((0x800000U 
                                                        | (0x7fffffU 
                                                           & vlSelf->tb_adder__DOT__tb_data2)) 
                                                       >> (IData)(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub)))
                                                    : 0U);
    } else {
        vlSelf->tb_adder__DOT__DUT__DOT__biggerExp 
            = (0xffU & (vlSelf->tb_adder__DOT__tb_data2 
                        >> 0x17U));
        vlSelf->tb_adder__DOT__DUT__DOT__exp_sub = 
            (0xffU & ((IData)(1U) + ((~ (vlSelf->tb_adder__DOT__tb_data1 
                                         >> 0x17U)) 
                                     + (vlSelf->tb_adder__DOT__tb_data2 
                                        >> 0x17U))));
        vlSelf->tb_adder__DOT__DUT__DOT__shift2 = (0x800000U 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__tb_data2));
        vlSelf->tb_adder__DOT__DUT__DOT__shift1 = (
                                                   (0x17U 
                                                    >= (IData)(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub))
                                                    ? 
                                                   (0xffffffU 
                                                    & ((0x800000U 
                                                        | (0x7fffffU 
                                                           & vlSelf->tb_adder__DOT__tb_data1)) 
                                                       >> (IData)(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub)))
                                                    : 0U);
    }
    vlSelf->tb_adder__DOT__DUT__DOT__shift_int = 0U;
    vlSelf->tb_adder__DOT__DUT__DOT__carry = 0U;
    if (vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0) {
        vlSelf->tb_adder__DOT__DUT__DOT__sign_result 
            = (1U & (vlSelf->tb_adder__DOT__tb_data1 
                     >> 0x1fU));
        vlSelf->tb_adder__DOT__DUT__DOT__temp = (0x1ffffffU 
                                                 & ((0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift1) 
                                                    + 
                                                    (0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift2)));
        vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
            = (0x3ffffffU & (vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                             + vlSelf->tb_adder__DOT__DUT__DOT__shift2));
        vlSelf->tb_adder__DOT__DUT__DOT__carry = (1U 
                                                  & (vlSelf->tb_adder__DOT__DUT__DOT__temp 
                                                     >> 0x18U));
    } else if ((vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                > vlSelf->tb_adder__DOT__DUT__DOT__shift2)) {
        vlSelf->tb_adder__DOT__DUT__DOT__sign_result 
            = (1U & (vlSelf->tb_adder__DOT__tb_data1 
                     >> 0x1fU));
        vlSelf->tb_adder__DOT__DUT__DOT__shift_int 
            = (0x1ffffffU & ((IData)(1U) + (~ vlSelf->tb_adder__DOT__DUT__DOT__shift2)));
        vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
            = (0x3ffffffU & (vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                             + vlSelf->tb_adder__DOT__DUT__DOT__shift_int));
        vlSelf->tb_adder__DOT__DUT__DOT__temp = (0x1ffffffU 
                                                 & ((0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift1) 
                                                    + 
                                                    (0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift_int)));
        vlSelf->tb_adder__DOT__DUT__DOT__carry = (1U 
                                                  & (vlSelf->tb_adder__DOT__DUT__DOT__temp 
                                                     >> 0x18U));
    } else {
        vlSelf->tb_adder__DOT__DUT__DOT__sign_result 
            = (1U & (vlSelf->tb_adder__DOT__tb_data2 
                     >> 0x1fU));
        vlSelf->tb_adder__DOT__DUT__DOT__shift_int 
            = (0x1ffffffU & ((IData)(1U) + (~ vlSelf->tb_adder__DOT__DUT__DOT__shift1)));
        vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
            = (0x3ffffffU & (vlSelf->tb_adder__DOT__DUT__DOT__shift2 
                             + vlSelf->tb_adder__DOT__DUT__DOT__shift_int));
        vlSelf->tb_adder__DOT__DUT__DOT__temp = (0x1ffffffU 
                                                 & ((0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift2) 
                                                    + 
                                                    (0xffffffU 
                                                     & vlSelf->tb_adder__DOT__DUT__DOT__shift_int)));
        vlSelf->tb_adder__DOT__DUT__DOT__carry = (1U 
                                                  & (vlSelf->tb_adder__DOT__DUT__DOT__temp 
                                                     >> 0x18U));
    }
    if (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__carry) 
         & (~ (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
               >> 0x19U)))) {
        vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
            = (0xffffffU & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                            >> 1U));
        vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
            = (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_adder__DOT__DUT__DOT__biggerExp)));
    } else {
        vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
            = (0xffffffU & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult);
        vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
            = vlSelf->tb_adder__DOT__DUT__DOT__biggerExp;
        if (((((((((0x800000U == (0x1800000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult)) 
                   | (0x400000U == (0x1c00000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                  | (0x200000U == (0x1e00000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                 | (0x100000U == (0x1f00000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                | (0x80000U == (0x1f80000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
               | (0x40000U == (0x1fc0000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
              | (0x20000U == (0x1fe0000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
             | (0x10000U == (0x1ff0000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult)))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xffffffU & ((0x800000U == (0x1800000U 
                                               & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                 ? vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult
                                 : ((0x400000U == (0x1c00000U 
                                                   & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                     ? (0xfffffeU & 
                                        (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                         << 1U)) : 
                                    ((0x200000U == 
                                      (0x1e00000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                      ? (0xfffffcU 
                                         & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                            << 2U))
                                      : ((0x100000U 
                                          == (0x1f00000U 
                                              & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                          ? (0xfffff8U 
                                             & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                                << 3U))
                                          : ((0x80000U 
                                              == (0x1f80000U 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                              ? (0xfffff0U 
                                                 & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                                    << 4U))
                                              : ((0x40000U 
                                                  == 
                                                  (0x1fc0000U 
                                                   & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                                  ? 
                                                 (0xffffe0U 
                                                  & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                                     << 5U))
                                                  : 
                                                 ((0x20000U 
                                                   == 
                                                   (0x1fe0000U 
                                                    & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                                   ? 
                                                  (0xffffc0U 
                                                   & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                                      << 6U))
                                                   : 
                                                  (0xffff80U 
                                                   & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                                      << 7U))))))))));
            if ((0x800000U != (0x1800000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((0x400000U == (0x1c00000U 
                                               & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                 ? ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                    - (IData)(1U)) : 
                                ((0x200000U == (0x1e00000U 
                                                & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                  ? ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     - (IData)(2U))
                                  : ((0x100000U == 
                                      (0x1f00000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                      ? ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                         - (IData)(3U))
                                      : ((0x80000U 
                                          == (0x1f80000U 
                                              & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                          ? ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                             - (IData)(4U))
                                          : ((0x40000U 
                                              == (0x1fc0000U 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                              ? ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                 - (IData)(5U))
                                              : ((0x20000U 
                                                  == 
                                                  (0x1fe0000U 
                                                   & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))
                                                  ? 
                                                 ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                  - (IData)(6U))
                                                  : 
                                                 ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                  - (IData)(7U)))))))));
            }
        } else if (((((((((0x8000U == (0x1ff8000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult)) 
                          | (0x4000U == (0x1ffc000U 
                                         & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                         | (0x2000U == (0x1ffe000U 
                                        & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                        | (0x1000U == (0x1fff000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                       | (0x800U == (0x1fff800U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                      | (0x400U == (0x1fffc00U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                     | (0x200U == (0x1fffe00U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) 
                    | (0x100U == (0x1ffff00U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult)))) {
            if ((0x8000U == (0x1ff8000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xffff00U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 8U));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(8U)));
            } else if ((0x4000U == (0x1ffc000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xfffe00U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 9U));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(9U)));
            } else if ((0x2000U == (0x1ffe000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xfffc00U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xaU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xaU)));
            } else if ((0x1000U == (0x1fff000U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xfff800U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xbU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xbU)));
            } else if ((0x800U == (0x1fff800U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xfff000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xcU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xcU)));
            } else if ((0x400U == (0x1fffc00U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xffe000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xdU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xdU)));
            } else if ((0x200U == (0x1fffe00U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xffc000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xeU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xeU)));
            } else {
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                    = (0xff8000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                    << 0xfU));
                vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                    = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                - (IData)(0xfU)));
            }
        } else if ((0x80U == (0x1ffff80U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xff0000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x10U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x10U)));
        } else if ((0x40U == (0x1ffffc0U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xfe0000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x11U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x11U)));
        } else if ((0x20U == (0x1ffffe0U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xfc0000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x12U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x12U)));
        } else if ((0x10U == (0x1fffff0U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xf80000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x13U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x13U)));
        } else if ((8U == (0x1fffff8U & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xf00000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x14U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x14U)));
        } else if ((4U == (0x1fffffcU & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xe00000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x15U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x15U)));
        } else if ((2U == (0x1fffffeU & vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult))) {
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant 
                = (0xc00000U & (vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult 
                                << 0x16U));
            vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp 
                = (0xffU & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                            - (IData)(0x16U)));
        }
    }
    vlSelf->tb_adder__DOT__DUT__DOT__overflow_temp 
        = (0xffU <= (IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp));
    vlSelf->tb_adder__DOT__DUT__DOT__underflow_temp 
        = (0U == (IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp));
}

void Vadder___024root___eval_act(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vadder___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
}

void Vadder___024root___eval_nba(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vadder___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[4U] = 1U;
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
