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
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[3U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgIData(oldp+6,(vlSelf->tb_adder__DOT__tb_result),32);
        bufp->chgCData(oldp+7,(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub),8);
        bufp->chgIData(oldp+8,(vlSelf->tb_adder__DOT__DUT__DOT__mant1),23);
        bufp->chgIData(oldp+9,(vlSelf->tb_adder__DOT__DUT__DOT__mant2),23);
        bufp->chgCData(oldp+10,(vlSelf->tb_adder__DOT__DUT__DOT__biggerExp),8);
        bufp->chgIData(oldp+11,(vlSelf->tb_adder__DOT__DUT__DOT__shift1),23);
        bufp->chgIData(oldp+12,(vlSelf->tb_adder__DOT__DUT__DOT__shift2),23);
    }
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
