// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vsubtraction__Syms.h"


VL_ATTR_COLD void Vsubtraction___024root__trace_init_sub__TOP__0(Vsubtraction___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("tb_sub ");
    tracep->declBus(c+1,"tb_data1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2,"tb_data2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,"tb_result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("DUT ");
    tracep->declBus(c+1,"data1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2,"data2",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+11,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+3,"data1_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+4,"data2_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+5,"sign1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+6,"sign2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+7,"exp1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+8,"exp2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+9,"shift1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 22,0);
    tracep->declBus(c+10,"shift2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 22,0);
    tracep->declBus(c+12,"mant1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 22,0);
    tracep->declBus(c+13,"mant2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 22,0);
    tracep->declBus(c+14,"count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+15,"biggerEXP",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+16,"exp_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vsubtraction___024root__trace_init_top(Vsubtraction___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_init_top\n"); );
    // Body
    Vsubtraction___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vsubtraction___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vsubtraction___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vsubtraction___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vsubtraction___024root__trace_register(Vsubtraction___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vsubtraction___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vsubtraction___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vsubtraction___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vsubtraction___024root__trace_full_sub_0(Vsubtraction___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vsubtraction___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_full_top_0\n"); );
    // Init
    Vsubtraction___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsubtraction___024root*>(voidSelf);
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vsubtraction___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vsubtraction___024root__trace_full_sub_0(Vsubtraction___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->tb_sub__DOT__tb_data1),32);
    bufp->fullIData(oldp+2,(vlSelf->tb_sub__DOT__tb_data2),32);
    bufp->fullIData(oldp+3,(((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1))),32);
    bufp->fullIData(oldp+4,(((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data2))),32);
    bufp->fullBit(oldp+5,((((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                           >> 0x1fU)));
    bufp->fullBit(oldp+6,((((IData)(1U) + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                           >> 0x1fU)));
    bufp->fullCData(oldp+7,((0xffU & (((IData)(1U) 
                                       + (~ vlSelf->tb_sub__DOT__tb_data1)) 
                                      >> 0x17U))),8);
    bufp->fullCData(oldp+8,((0xffU & (((IData)(1U) 
                                       + (~ vlSelf->tb_sub__DOT__tb_data2)) 
                                      >> 0x17U))),8);
    bufp->fullIData(oldp+9,((0x7fffffU & ((IData)(1U) 
                                          + (~ vlSelf->tb_sub__DOT__tb_data1)))),23);
    bufp->fullIData(oldp+10,((0x7fffffU & ((IData)(1U) 
                                           + (~ vlSelf->tb_sub__DOT__tb_data2)))),23);
    bufp->fullIData(oldp+11,(vlSelf->tb_sub__DOT__tb_result),32);
    bufp->fullIData(oldp+12,(vlSelf->tb_sub__DOT__DUT__DOT__mant1),23);
    bufp->fullIData(oldp+13,(vlSelf->tb_sub__DOT__DUT__DOT__mant2),23);
    bufp->fullCData(oldp+14,(vlSelf->tb_sub__DOT__DUT__DOT__count),8);
    bufp->fullCData(oldp+15,(vlSelf->tb_sub__DOT__DUT__DOT__biggerEXP),8);
    bufp->fullCData(oldp+16,(vlSelf->tb_sub__DOT__DUT__DOT__exp_sub),8);
}
