// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vsubtraction__Syms.h"


void Vsubtraction___024root__trace_chg_sub_0(Vsubtraction___024root* vlSelf, VerilatedFst::Buffer* bufp);

void Vsubtraction___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_chg_top_0\n"); );
    // Init
    Vsubtraction___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsubtraction___024root*>(voidSelf);
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vsubtraction___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vsubtraction___024root__trace_chg_sub_0(Vsubtraction___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgIData(oldp+0,(vlSelf->tb_sub__DOT__tb_data1),32);
        bufp->chgIData(oldp+1,(vlSelf->tb_sub__DOT__tb_data2),32);
        bufp->chgIData(oldp+2,(((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1))),32);
        bufp->chgIData(oldp+3,(((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data2))),32);
        bufp->chgBit(oldp+4,((((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                              >> 0x1fU)));
        bufp->chgBit(oldp+5,((((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                              >> 0x1fU)));
        bufp->chgCData(oldp+6,((0xffU & (((IData)(1U) 
                                          + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                         >> 0x17U))),8);
        bufp->chgCData(oldp+7,((0xffU & (((IData)(1U) 
                                          + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                         >> 0x17U))),8);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[3U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgIData(oldp+8,(vlSelf->tb_sub__DOT__tb_result),32);
        bufp->chgIData(oldp+9,(vlSelf->tb_sub__DOT__DUT__DOT__shift1),23);
        bufp->chgIData(oldp+10,(vlSelf->tb_sub__DOT__DUT__DOT__shift2),23);
        bufp->chgIData(oldp+11,(vlSelf->tb_sub__DOT__DUT__DOT__mant1),23);
        bufp->chgIData(oldp+12,(vlSelf->tb_sub__DOT__DUT__DOT__mant2),23);
        bufp->chgCData(oldp+13,(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP),8);
        bufp->chgCData(oldp+14,(vlSelf->tb_sub__DOT__DUT__DOT__exp_sub),8);
    }
}

void Vsubtraction___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_cleanup\n"); );
    // Init
    Vsubtraction___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsubtraction___024root*>(voidSelf);
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
}
