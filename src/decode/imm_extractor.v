`timescale 1ns / 1ps
`ifndef IMM_EXTRACTOR_V
`define IMM_EXTRACTOR_V

module imm_extractor(
    input [24:0] instruction_data, // 25-bit instruction data (after opcode removal)
    input specifier,               // Determines U-Type (0) or J-Type (1)
    output reg [20:0] imm,         // 21-bit immediate (shared for U-Type and J-Type)
    output reg [4:0] rd            // Destination register
);

    always @(*) begin
        // Extract `rd` from instruction_data[4:0]
        rd = instruction_data[4:0];

        if (specifier == 1'b0) begin
            // U-Type Instruction (LUI, AUIPC) → 20-bit immediate stored in 21-bit field (MSB zero)
            imm = {instruction_data[24:5], 1'b0}; // Pad with LSB zero for consistency
        end else begin
            // J-Type Instruction (JAL) → 21-bit immediate
            imm = {instruction_data[24],  // Bit 20 (MSB)
                   instruction_data[12:5], // Bits 19:12
                   instruction_data[13],   // Bit 11
                   instruction_data[23:14] // Bits 10:1
                  };
        end
    end

endmodule

`endif // IMM_EXTRACTOR_V
