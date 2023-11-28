// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "transaction.svh"

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
//             bins zero = {16'b0};
//             bins pos_normal = {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins neg_normal = {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins pos_subnormal = {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins neg_subnormal = {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins pos_NaN = {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins neg_NaN = {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins Inf = {16'b0111110000000000};
//             bins nInf = {16'b1111110000000000};
//         }
//     endgroup

//     covergroup float2_in;
//         cov_float2: coverpoint txn.float2 {
//             bins zero = {16'b0};
//             bins pos_normal = {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins neg_normal = {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins pos_subnormal = {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins neg_subnormal = {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins pos_NaN = {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins neg_NaN = {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins Inf = {16'b0111110000000000};
//             bins nInf = {16'b1111110000000000};
//         }
//     endgroup

//     covergroup product_out;
//         real cov_product: coverpoint txn.product {
//             bins zero = {16'b0};
//             bins pos_normal = {[16'b0011110000000000 : 16'b0111101111111111]};
//             bins neg_normal = {[16'b1011110000000000 : 16'b1111101111111111]};
//             bins pos_subnormal = {[16'b0000000000000001 : 16'b0000001111111111]};
//             bins neg_subnormal = {[16'b1000000000000001 : 16'b1000001111111111]};
//             bins pos_NaN = {[16'b0111110000000001 : 16'b0111111111111111]};
//             bins neg_NaN = {[16'b1111110000000001 : 16'b1111111111111111]};
//             bins Inf = {16'b0111110000000000};
//             bins nInf = {16'b1111110000000000};
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