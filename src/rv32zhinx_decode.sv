import fpu_types_pkg::*;

module rv32zhinx_decode (
    input [31:0] insn,
    output fpu_operation_t operation
);

    rv32zhinx_insn_t insn_split;

    assign insn_split = rv32zhinx_insn_t'(insn); 

    always_comb begin
        casez (fpu_operation_t'(insn_split.opcode))
            OPCODE_OPFP: begin 
                casez (fpu_funct_t'(insn_split.funct5))
                    FUNCT_FADD: operation = FPU_HALF_ADD;
                    FUNCT_FSUB: operation = FPU_HALF_SUB;
                    FUNCT_FMUL: operation = FPU_HALF_MUL;
                    FUNCT_FDIV: operation = FPU_HALF_DIV;
                    FUNCT_FMINMAX: begin
                        casez (fpu_rm_t'(insn_split.rm))
                        RM_FMIN: operation = FPU_HALF_MIN;
                        RM_FMAX: operation = FPU_HALF_MAX;
                        endcase
                    end
                    FUNCT_FSQRT: operation = FPU_HALF_SQRT;
                    FUNCT_FSGNJ: operation = FPU_HALF_SGNJ;
                    FUNCT_FCOMP: begin
                        casez (fpu_cmp_rm_t'(insn_split.rm))
                        RM_FEQ: operation = FPU_HALF_FEQ;
                        RM_FLT: operation = FPU_HALF_FLT;
                        RM_FLE: operation = FPU_HALF_FLE;
                        endcase
                    end
                    FUNCT_FCLASS: operation = FPU_HALF_CLASS;
                endcase
            end
            OPCODE_FMADD: operation = FPU_HALF_MADD;
            OPCODE_FMSUB: operation = FPU_HALF_MSUB;
            OPCODE_FNMADD: operation = FPU_HALF_NMADD;
            OPCODE_FNMSUB: operation = FPU_HALF_NMSUB;
        endcase
    end

endmodule