// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vadder__Syms.h"


VL_ATTR_COLD void Vadder___024root__trace_init_sub__TOP__0(Vadder___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("tb_adder ");
    tracep->declBus(c+1,"tb_data1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2,"tb_data2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+21,"tb_result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+9,"tb_underflow",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+10,"tb_overflow",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("DUT ");
    tracep->declBus(c+1,"data1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2,"data2",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+21,"result",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+10,"overflow",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+9,"underflow",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+3,"sign1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+4,"sign2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+5,"exp1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+6,"exp2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+7,"mant1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 23,0);
    tracep->declBus(c+8,"mant2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 23,0);
    tracep->declBus(c+11,"exp_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBit(c+22,"sign_result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+12,"mantissaResult",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 25,0);
    tracep->declBus(c+13,"shift1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 24,0);
    tracep->declBus(c+14,"shift2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 24,0);
    tracep->declBus(c+15,"shift_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 24,0);
    tracep->declBus(c+16,"biggerExp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+17,"normalized_exp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+18,"normalized_mant",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 23,0);
    tracep->declBit(c+10,"overflow_temp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+9,"underflow_temp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+19,"carry",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+20,"temp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 24,0);
    tracep->declBus(c+23,"mr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 24,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vadder___024root__trace_init_top(Vadder___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_init_top\n"); );
    // Body
    Vadder___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vadder___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vadder___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vadder___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vadder___024root__trace_register(Vadder___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vadder___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vadder___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vadder___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vadder___024root__trace_full_sub_0(Vadder___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vadder___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_full_top_0\n"); );
    // Init
    Vadder___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vadder___024root*>(voidSelf);
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vadder___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vadder___024root__trace_full_sub_0(Vadder___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->tb_adder__DOT__tb_data1),32);
    bufp->fullIData(oldp+2,(vlSelf->tb_adder__DOT__tb_data2),32);
    bufp->fullBit(oldp+3,((vlSelf->tb_adder__DOT__tb_data1 
                           >> 0x1fU)));
    bufp->fullBit(oldp+4,((vlSelf->tb_adder__DOT__tb_data2 
                           >> 0x1fU)));
    bufp->fullCData(oldp+5,((0xffU & (vlSelf->tb_adder__DOT__tb_data1 
                                      >> 0x17U))),8);
    bufp->fullCData(oldp+6,((0xffU & (vlSelf->tb_adder__DOT__tb_data2 
                                      >> 0x17U))),8);
    bufp->fullIData(oldp+7,((0x800000U | (0x7fffffU 
                                          & vlSelf->tb_adder__DOT__tb_data1))),24);
    bufp->fullIData(oldp+8,((0x800000U | (0x7fffffU 
                                          & vlSelf->tb_adder__DOT__tb_data2))),24);
    bufp->fullBit(oldp+9,(vlSelf->tb_adder__DOT__DUT__DOT__underflow_temp));
    bufp->fullBit(oldp+10,(vlSelf->tb_adder__DOT__DUT__DOT__overflow_temp));
    bufp->fullCData(oldp+11,(vlSelf->tb_adder__DOT__DUT__DOT__exp_sub),8);
    bufp->fullIData(oldp+12,(vlSelf->tb_adder__DOT__DUT__DOT__mantissaResult),26);
    bufp->fullIData(oldp+13,(vlSelf->tb_adder__DOT__DUT__DOT__shift1),25);
    bufp->fullIData(oldp+14,(vlSelf->tb_adder__DOT__DUT__DOT__shift2),25);
    bufp->fullIData(oldp+15,(vlSelf->tb_adder__DOT__DUT__DOT__shift_int),25);
    bufp->fullCData(oldp+16,(vlSelf->tb_adder__DOT__DUT__DOT__biggerExp),8);
    bufp->fullCData(oldp+17,(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp),8);
    bufp->fullIData(oldp+18,(vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant),24);
    bufp->fullBit(oldp+19,(vlSelf->tb_adder__DOT__DUT__DOT__carry));
    bufp->fullIData(oldp+20,(vlSelf->tb_adder__DOT__DUT__DOT__temp),25);
    bufp->fullIData(oldp+21,(((((IData)(vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0)
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
    bufp->fullBit(oldp+22,((1U & ((IData)(vlSelf->tb_adder__DOT__DUT__DOT____VdfgExtracted_h9ee74b83__0)
                                   ? (vlSelf->tb_adder__DOT__tb_data1 
                                      >> 0x1fU) : (
                                                   (vlSelf->tb_adder__DOT__DUT__DOT__shift1 
                                                    > vlSelf->tb_adder__DOT__DUT__DOT__shift2)
                                                    ? 
                                                   (vlSelf->tb_adder__DOT__tb_data1 
                                                    >> 0x1fU)
                                                    : 
                                                   (vlSelf->tb_adder__DOT__tb_data2 
                                                    >> 0x1fU))))));
    bufp->fullIData(oldp+23,(0U),25);
}
