`timescale 1ns / 1ps
`ifndef INSTRUCTION_COMMON_FIELDS_V
`define INSTRUCTION_COMMON_FIELDS_V

module instruction_common_fields(
    input [24:0] instruction_data,  // Instruction without opcode
    input [1:0]  group,
    input        specifier,
    output reg [4:0] rs1,           // Extracted rs1 (5 bits)
    output reg [2:0] funct3,        // Extracted funct3 (3 bits)
    output reg [6:0] funct7,        // Extracted funct7 (7 bits)
    output reg [4:0] rs2,           // Extracted rs2 (5 bits)
    output reg [4:0] rd,            // Extracted rd (5 bits)

    // Immediate sub-fields
    output reg [11:0] imm_i12,      // For I-Type (12 bits)
    output reg [6:0]  imm_s7,       // Upper 7 bits for S-Type
    output reg [4:0]  imm_s5,       // Lower 5 bits for S-Type
    output reg [6:0]  imm_b7,       // Upper 7 bits for B-Type
    output reg [4:0]  imm_b5        // Lower 5 bits for B-Type
);

    always @(*) begin
        // -------------------------
        // Basic Field Extraction
        // -------------------------
        rs1    = instruction_data[12:8];   // bits [12:8]
        funct3 = instruction_data[7:5];    // bits [7:5]
        rd     = instruction_data[4:0];    // bits [4:0]
        rs2    = instruction_data[17:13];  // bits [17:13]
        funct7 = instruction_data[24:18];  // bits [24:18]

        // Initialize all immediate outputs to zero by default
        imm_i12 = 12'b0;
        imm_s7  = 7'b0;
        imm_s5  = 5'b0;
        imm_b7  = 7'b0;
        imm_b5  = 5'b0;

        // -------------------------
        // Immediate Decoding
        // -------------------------
        case (group)
            2'b01: begin
                // R and I-Type
                if (specifier == 1'b1) begin
                    // I-Type: 12-bit immediate from bits [24:13]
                    imm_i12 = instruction_data[24:13];
                end
                // R-Type has no immediate
            end

            2'b10: begin
                // S and B-Type
                if (specifier == 1'b0) begin
                    // S-Type: upper 7 bits + lower 5 bits
                    imm_s7 = instruction_data[24:18];
                    imm_s5 = instruction_data[4:0];
                end else begin
                    // B-Type: upper 7 bits + lower 5 bits
                    imm_b7 = instruction_data[24:18];
                    imm_b5 = instruction_data[4:0];
                end
            end
        endcase
    end

endmodule

`endif // INSTRUCTION_COMMON_FIELDS_V
