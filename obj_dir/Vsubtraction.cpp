// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vsubtraction.h"
#include "Vsubtraction__Syms.h"

//============================================================
// Constructors

Vsubtraction::Vsubtraction(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vsubtraction__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vsubtraction::Vsubtraction(const char* _vcname__)
    : Vsubtraction(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vsubtraction::~Vsubtraction() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vsubtraction___024root___eval_debug_assertions(Vsubtraction___024root* vlSelf);
#endif  // VL_DEBUG
void Vsubtraction___024root___eval_static(Vsubtraction___024root* vlSelf);
void Vsubtraction___024root___eval_initial(Vsubtraction___024root* vlSelf);
void Vsubtraction___024root___eval_settle(Vsubtraction___024root* vlSelf);
void Vsubtraction___024root___eval(Vsubtraction___024root* vlSelf);

void Vsubtraction::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vsubtraction::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vsubtraction___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vsubtraction___024root___eval_static(&(vlSymsp->TOP));
        Vsubtraction___024root___eval_initial(&(vlSymsp->TOP));
        Vsubtraction___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vsubtraction___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vsubtraction::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vsubtraction::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vsubtraction::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vsubtraction___024root___eval_final(Vsubtraction___024root* vlSelf);

VL_ATTR_COLD void Vsubtraction::final() {
    Vsubtraction___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vsubtraction::hierName() const { return vlSymsp->name(); }
const char* Vsubtraction::modelName() const { return "Vsubtraction"; }
unsigned Vsubtraction::threads() const { return 1; }
