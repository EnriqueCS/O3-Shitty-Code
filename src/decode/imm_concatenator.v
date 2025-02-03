`timescale 1ns / 1ps
`ifndef IMM_CONCATENATOR_V
`define IMM_CONCATENATOR_V

module imm_concatenator(
    // Control
    input  [1:0]  group,       // 2'b01 => R/I, 2'b10 => S/B, 2'b11 => U/J
    input         specifier,   // 0 or 1 bit: R vs I, S vs B, U vs J

    // Sub-immediates from common fields
    input  [11:0] imm_i12,     // I-Type
    input  [6:0]  imm_s7,      // S-Type upper bits
    input  [4:0]  imm_s5,      // S-Type lower bits
    input  [6:0]  imm_b7,      // B-Type upper bits
    input  [4:0]  imm_b5,      // B-Type lower bits

    // Imm from imm_extractor for U/J
    input  [20:0] imm_uj,      // 21-bit immediate from imm_extractor

    // Outputs
    output reg [20:0] imm_out, // Unified 21-bit immediate
    output reg        use_uj_rd // Tells us if we should use rd from imm_extractor
);

    always @(*) begin
        // Defaults
        imm_out   = 21'b0;
        use_uj_rd = 1'b0;

        case (group)
            //-------------------------------------------------------------
            // Group=01 => R (specifier=0) or I (specifier=1)
            //-------------------------------------------------------------
            2'b01: begin
                if (specifier == 1'b1) begin
                    // I-Type => sign-extend imm_i12 (12 bits) into 21 bits
                    imm_out = {{9{imm_i12[11]}}, imm_i12};
                end else begin
                    // R-Type => no immediate
                    imm_out = 21'b0;
                end
            end

            //-------------------------------------------------------------
            // Group=10 => S (specifier=0) or B (specifier=1)
            //-------------------------------------------------------------
            2'b10: begin
                if (specifier == 1'b0) begin
                    // S-Type => bits [6:0] + [4:0], total 12 bits => sign-extend
                    imm_out = {{9{imm_s7[6]}}, imm_s7, imm_s5};
                end else begin
                    // B-Type => bits [6:0] + [4:0], total 12 bits => sign-extend
                    imm_out = {{9{imm_b7[6]}}, imm_b7, imm_b5};
                end
            end

            //-------------------------------------------------------------
            // Group=11 => U (specifier=0) or J (specifier=1)
            //-------------------------------------------------------------
            2'b11: begin
                // imm_uj is already formed by imm_extractor
                imm_out   = imm_uj;
                use_uj_rd = 1'b1;  // We'll know we must take rd from imm_extractor
            end

            //-------------------------------------------------------------
            default: begin
                imm_out   = 21'b0;
                use_uj_rd = 1'b0;
            end
        endcase
    end

endmodule

`endif // IMM_CONCATENATOR_V
