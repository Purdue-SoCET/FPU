// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "transaction.svh"
// `include "uvm_fpu_pkg.vh"
// import uvm_fpu_pkg::*;
// `uvm_analysis_imp_decl(_port_outp)
// class coverage extends uvm_subscriber#(transaction);
//     `uvm_component_utils(coverage)
    
//     uvm_analysis_imp_port_outp#(transaction,coverage) analysis_imp_outp;
//     uvm_analysis_port#(transaction) cov_ap;
//     transaction txn;
//     real cov_float1;
//     real cov_float2;
//     real cov_product;
//     covergroup float1_in;
//         cov_float1: coverpoint txn.float1 {
//             bins zero_cov = {ZERO};
//             //pos_normal_cov {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins pos_normal_cov = {[{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_normal_cov {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins neg_normal_cov = {[{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_subnormal_cov {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins pos_subnormal_cov = {[{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_subnormal_cov {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins neg_subnormal_cov = {[{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_NaN_cov {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins pos_NaN_cov= {[{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_NaN_cov {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins neg_NaN_cov = {[{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             bins Inf_cov = {INF};
//             bins nInf_cov = {NINF};
//         }
//     endgroup

//     covergroup float2_in;
//         cov_float2: coverpoint txn.float2 {
//             bins zero_cov = {ZERO};
//             //pos_normal_cov {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins pos_normal_cov = {[{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_normal_cov {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins neg_normal_cov = {[{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_subnormal_cov {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins pos_subnormal_cov = {[{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_subnormal_cov {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins neg_subnormal_cov = {[{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_NaN_cov {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins pos_NaN_cov= {[{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_NaN_cov {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins neg_NaN_cov = {[{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             bins Inf_cov = {INF};
//             bins nInf_cov = {NINF};
//         }
//     endgroup

//     covergroup product_out;
//         real cov_product: coverpoint txn.product {
//             bins zero_cov = {ZERO};
//             //pos_normal_cov {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins pos_normal_cov = {[{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_normal_cov {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins neg_normal_cov = {[{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b0}}}:{1'b1, {EXPONENT_WIDTH-1{1'b1}},1'b0, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_subnormal_cov {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins pos_subnormal_cov = {[{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_subnormal_cov {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins neg_subnormal_cov = {[{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH{1'b1}}}]};

//             //pos_NaN_cov {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins pos_NaN_cov= {[{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             //neg_NaN_cov {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins neg_NaN_cov = {[{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH-1{1'b0}},1'b1}:{1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}}]};

//             bins Inf_cov = {INF};
//             bins nInf_cov = {NINF};
//         }
//     endgroup

//     function new(string name, uvm_component parent = null);
//         super.new(name, parent);
//         analysis_imp_outp =  new("ap_outp", this);
//         float1_in = new();
//         float2_in = new();
//         product_out = new();
//     endfunction 

//     function void build_phase(uvm_phase phase);
//         cov_ap = new("cov_ap", this);
//     endfunction

//     function void write(transaction t); 
//         this.txn = t;
//     endfunction

//     virtual function void write_port_outp(transaction t);  
//         this.txn = t;
//         float1_in.sample();
//         float2_in.sample();
//         product_out.sample();
//     endfunction

//     function void extract_phase(uvm_phase phase);    
//         cov_float1 = float1_in.get_coverage();
//         cov_float2 = float2_in.get_coverage();
//         cov_product = product_out.get_coverage();
//     endfunction

//     function void report_phase(uvm_phase phase);
//         `uvm_info(get_full_name(),$sformatf("Float1 Coverage is %d",cov_float1),UVM_LOW)
//         `uvm_info(get_full_name(),$sformatf("Float2 Coverage is %d",cov_float2),UVM_LOW)
//         `uvm_info(get_full_name(),$sformatf("Product Coverage is %d",cov_product),UVM_LOW)
//     endfunction

// endclass 