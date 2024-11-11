// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vadder.h for the primary calling header

#include "verilated.h"

#include "Vadder__Syms.h"
#include "Vadder__Syms.h"
#include "Vadder___024root.h"

VL_INLINE_OPT VlCoroutine Vadder___024root___eval_initial__TOP__0(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_initial__TOP__0\n"); );
    // Init
    VlWide<5>/*159:0*/ __Vtemp_haca5b60e__0;
    // Body
    __Vtemp_haca5b60e__0[0U] = 0x2e667374U;
    __Vtemp_haca5b60e__0[1U] = 0x666f726dU;
    __Vtemp_haca5b60e__0[2U] = 0x77617665U;
    __Vtemp_haca5b60e__0[3U] = 0x6465725fU;
    __Vtemp_haca5b60e__0[4U] = 0x4164U;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(5, __Vtemp_haca5b60e__0));
    vlSymsp->_traceDumpOpen();
    vlSelf->tb_adder__DOT__tb_data1 = 0x42c86666U;
    vlSelf->tb_adder__DOT__tb_data2 = 0x42b50000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       26);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x433eb333U != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value 190.7. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0x4249999aU;
    vlSelf->tb_adder__DOT__tb_data2 = 0x42c9999aU;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       43);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x43173333U != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value 151.2. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0xc2acfae1U;
    vlSelf->tb_adder__DOT__tb_data2 = 0xc4163852U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       52);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc42bd7aeU != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value -687.37. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0xc3f6e666U;
    vlSelf->tb_adder__DOT__tb_data2 = 0xc376e666U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       61);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc4392ccdU != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value -740.7. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0x43163333U;
    vlSelf->tb_adder__DOT__tb_data2 = 0xc1f40000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       69);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x42ef6666U != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value 119.7. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0x42c86666U;
    vlSelf->tb_adder__DOT__tb_data2 = 0xc2b50000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       81);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x411b3333U != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value 9.7. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    vlSelf->tb_adder__DOT__tb_data1 = 0xc2c86666U;
    vlSelf->tb_adder__DOT__tb_data2 = 0x42b50000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_add_single/tb_adder.sv", 
                                       99);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc11b3333U != (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                                      << 0x1fU) | (
                                                   ((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                                    << 0x17U) 
                                                   | (0x7fffffU 
                                                      & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant)))))) {
        VL_WRITEF("Wrong output, actual value -9.7. Yours: %10#\n",
                  32,(((IData)(vlSelf->tb_adder__DOT__DUT__DOT__sign_result) 
                       << 0x1fU) | (((IData)(vlSelf->tb_adder__DOT__DUT__DOT__normalized_exp) 
                                     << 0x17U) | (0x7fffffU 
                                                  & vlSelf->tb_adder__DOT__DUT__DOT__normalized_mant))));
    }
    VL_FINISH_MT("uvm_tb/uvm_tb_add_single/tb_adder.sv", 105, "");
    vlSelf->__Vm_traceActivity[2U] = 1U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vadder___024root___dump_triggers__act(Vadder___024root* vlSelf);
#endif  // VL_DEBUG

void Vadder___024root___eval_triggers__act(Vadder___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vadder__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vadder___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, vlSelf->__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vadder___024root___dump_triggers__act(vlSelf);
    }
#endif
}
