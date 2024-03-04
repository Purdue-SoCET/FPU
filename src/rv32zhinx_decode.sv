module rv32zhinx_decode (
    input [31:0] insn,
    // output logic claim,
    output fpu_types_pkg::rv32m_decode_t rv32zhinx_control
);
    import fpu_types_pkg::*;

    rv32zhinx_insn_t insn_split;

    assign insn_split = rv32zhinx_insn_t'(insn); 
    assign rv32zhinx_control.select = '0;
    assign rv32zhinx_control.op = '0;

    always_comb begin
        casez (fpu_funct_t'(insn_split.opcode))
            OPCODE_OPFP: begin 
                        rv32zhinx_control.select = 3'd0;
                        rv32zhinx_control.op = fpu_funct_t'(insn_split.funct5)
            end
            OPCODE_FMADD: rv32zhinx_control.select = 3'd1;
            OPCODE_FMSUB: rv32zhinx_control.select = 3'd2;
            OPCODE_FNMADD: rv32zhinx_control.select = 3'd3;
            OPCODE_FNMSUB: rv32zhinx_control.select = 3'd4;
        endcase
    end

endmodule