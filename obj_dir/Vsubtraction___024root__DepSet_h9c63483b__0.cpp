// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsubtraction.h for the primary calling header

#include "verilated.h"

#include "Vsubtraction__Syms.h"
#include "Vsubtraction__Syms.h"
#include "Vsubtraction___024root.h"

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
    VlWide<3>/*95:0*/ __Vtemp_h7b961df7__0;
    // Body
    __Vtemp_h7b961df7__0[0U] = 0x2e667374U;
    __Vtemp_h7b961df7__0[1U] = 0x666f726dU;
    __Vtemp_h7b961df7__0[2U] = 0x77617665U;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(3, __Vtemp_h7b961df7__0));
    vlSymsp->_traceDumpOpen();
    VL_WRITEF("Initializing data variables...\nRunning first test case.\n");
    vlSelf->tb_sub__DOT__tb_data1 = 0x42c86666U;
    vlSelf->tb_sub__DOT__tb_data2 = 0x42b50000U;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       33);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x3fcccccdU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [1]: Expected: 9.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\nRunning second test case.\n");
    __Vtask_tb_sub__DOT__setinputs__1__data2tb = 0x42c9999aU;
    __Vtask_tb_sub__DOT__setinputs__1__data1tb = 0x4249999aU;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__1__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__1__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       43);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc119999bU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [2]: Expected: -50.4. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\nRunning third test case.\n");
    __Vtask_tb_sub__DOT__setinputs__2__data2tb = 0xc4163852U;
    __Vtask_tb_sub__DOT__setinputs__2__data1tb = 0xc2acfae1U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__2__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__2__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       53);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x43a2fae1U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [3]: Expected: 514.39. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\nRunning fourth test case.\n");
    __Vtask_tb_sub__DOT__setinputs__3__data2tb = 0xc376e666U;
    __Vtask_tb_sub__DOT__setinputs__3__data1tb = 0xc3f6e666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__3__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__3__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       63);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc319999aU != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [4]: Expected: -246.9. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\nRunning fifth test case.\n");
    __Vtask_tb_sub__DOT__setinputs__4__data2tb = 0xc2b50000U;
    __Vtask_tb_sub__DOT__setinputs__4__data1tb = 0x42c86666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__4__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__4__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       73);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0x433eb333U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [5]: Expected: 190.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\nRunning sixth test case.\n");
    __Vtask_tb_sub__DOT__setinputs__5__data2tb = 0x42b50000U;
    __Vtask_tb_sub__DOT__setinputs__5__data1tb = 0xc2c86666U;
    vlSelf->tb_sub__DOT__tb_data1 = __Vtask_tb_sub__DOT__setinputs__5__data1tb;
    vlSelf->tb_sub__DOT__tb_data2 = __Vtask_tb_sub__DOT__setinputs__5__data2tb;
    co_await vlSelf->__VdlySched.delay(0xaULL, nullptr, 
                                       "uvm_tb/uvm_tb_sub_single/tb_sub.sv", 
                                       83);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY((0xc33eb333U != vlSelf->tb_sub__DOT__tb_result))) {
        VL_WRITEF("ERROR [6]: Expected: -190.7. Your output: %b\n",
                  32,vlSelf->tb_sub__DOT__tb_result);
    }
    VL_WRITEF("Test case done!\n");
    VL_FINISH_MT("uvm_tb/uvm_tb_sub_single/tb_sub.sv", 89, "");
    vlSelf->__Vm_traceActivity[2U] = 1U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsubtraction___024root___dump_triggers__act(Vsubtraction___024root* vlSelf);
#endif  // VL_DEBUG

void Vsubtraction___024root___eval_triggers__act(Vsubtraction___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsubtraction__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsubtraction___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, vlSelf->__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vsubtraction___024root___dump_triggers__act(vlSelf);
    }
#endif
}
