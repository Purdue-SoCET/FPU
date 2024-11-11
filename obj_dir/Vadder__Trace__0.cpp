// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vadder__Syms.h"


void Vadder___024root__trace_chg_sub_0(Vadder___024root* vlSelf, VerilatedFst::Buffer* bufp);

void Vadder___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_chg_top_0\n"); );
    // Init
    Vadder___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vadder___024root*>(voidSelf);
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vadder___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vadder___024root__trace_chg_sub_0(Vadder___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgIData(oldp+0,(vlSelf->tb_adder__DOT__tb_data1),32);
        bufp->chgIData(oldp+1,(vlSelf->tb_adder__DOT__tb_data2),32);
        bufp->chgBit(oldp+2,((vlSelf->tb_adder__DOT__tb_data1 
                              >> 0x1fU)));
        bufp->chgBit(oldp+3,((vlSelf->tb_adder__DOT__tb_data2 
                              >> 0x1fU)));
        bufp->chgCData(oldp+4,((0xffU & (vlSelf->tb_adder__DOT__tb_data1 
                                         >> 0x17U))),8);
        bufp->chgCData(oldp+5,((0xffU & (vlSelf->tb_adder__DOT__tb_data2 
                                         >> 0x17U))),8);
        bufp->chgIData(oldp+6,((0x800000U | (0x7fffffU 
                                             & vlSelf->tb_adder__DOT__tb_data1))),24);
        bufp->chgIData(oldp+7,((0x800000U | (0x7fffffU 
                                             & vlSelf->tb_adder__DOT__tb_data2))),24);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[3U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgBit(oldp+8,(vlSelf->tb_adder__DOT__DUT__DOT__underflow_temp));
        bufp->chgBit(oldp+9,(vlSelf->tb_adder__DOT__DUT__DOT__overflow_temp));
        bufp->chgCData(oldp+10,(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub),8);
        bufp->chgIData(oldp+11,(vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult),26);
        bufp->chgIData(oldp+12,(vlSelf->tb_adder__DOT__DUT__DOT__shift1),25);
        bufp->chgIData(oldp+13,(vlSelf->tb_adder__DOT__DUT__DOT__shift2),25);
        bufp->chgIData(oldp+14,(vlSelf->tb_adder__DOT__DUT__DOT__shift_int),25);
        bufp->chgCData(oldp+15,(vlSelf->tb_adder__DOT__DUT__DOT__biggerExp),8);
        bufp->chgCData(oldp+16,(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp),8);
        bufp->chgIData(oldp+17,(vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant),24);
        bufp->chgBit(oldp+18,(vlSelf->tb_adder__DOT__DUT__DOT__carry));
        bufp->chgIData(oldp+19,(vlSelf->tb_adder__DOT__DUT__DOT__temp),25);
    }
    bufp->chgIData(oldp+20,(((((IData)(vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0)
                                ? (vlSelf->tb_adder__DOT__tb_data1 
                                   >> 0x1fU) : ((vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                                                 > vlSelf->tb_adder__DOT__DUT__DOT__shift2)
                                                 ? 
                                                (vlSelf->tb_adder__DOT__tb_data1 
                                                 >> 0x1fU)
                                                 : 
                                                (vlSelf->tb_adder__DOT__tb_data2 
                                                 >> 0x1fU))) 
                              << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                            << 0x17U) 
                                           | (0x7fffffU 
                                              & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))),32);
    bufp->chgBit(oldp+21,((1U & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0)
                                  ? (vlSelf->tb_adder__DOT__tb_data1 
                                     >> 0x1fU) : ((vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                                                   > vlSelf->tb_adder__DOT__DUT__DOT__shift2)
                                                   ? 
                                                  (vlSelf->tb_adder__DOT__tb_data1 
                                                   >> 0x1fU)
                                                   : 
                                                  (vlSelf->tb_adder__DOT__tb_data2 
                                                   >> 0x1fU))))));
}

void Vadder___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_cleanup\n"); );
    // Init
    Vadder___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vadder___024root*>(voidSelf);
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
}
