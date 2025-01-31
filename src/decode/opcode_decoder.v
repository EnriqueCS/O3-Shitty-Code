`timescale 1ns / 1ps

module opcode_decoder(
    input [31:0] instruction,  // 32-bit RISC-V instruction
    // 3-bit format: R=000, I=001, S=010, B=011, U=100, J=101
    output reg [2:0] fmt       
);

    // Opcodes for each format
    localparam OPCODE_R_TYPE   = 7'b0110011;  // R-Type
    localparam OPCODE_I_ALU    = 7'b0010011;  // I-Type (ALU immediate)
    localparam OPCODE_I_LOAD   = 7'b0000011;  // I-Type (Load)
    localparam OPCODE_I_JALR   = 7'b1100111;  // I-Type (JALR)
    localparam OPCODE_S_TYPE   = 7'b0100011;  // S-Type (Store)
    localparam OPCODE_B_TYPE   = 7'b1100011;  // B-Type (Branch)
    localparam OPCODE_U_LUI    = 7'b0110111;  // U-Type (LUI)
    localparam OPCODE_U_AUIPC  = 7'b0010111;  // U-Type (AUIPC)
    localparam OPCODE_J_TYPE   = 7'b1101111;  // J-Type (JAL)

    always @(*) begin
        case (instruction[6:0])  // Check the first 7 bits (opcode)
            OPCODE_R_TYPE:    fmt = 3'b000;  // R-Type
            OPCODE_I_ALU,
            OPCODE_I_LOAD,
            OPCODE_I_JALR:    fmt = 3'b001;  // I-Type
            OPCODE_S_TYPE:    fmt = 3'b010;  // S-Type
            OPCODE_B_TYPE:    fmt = 3'b011;  // B-Type
            OPCODE_U_LUI,
            OPCODE_U_AUIPC:   fmt = 3'b100;  // U-Type
            OPCODE_J_TYPE:    fmt = 3'b101;  // J-Type
            default:          fmt = 3'b111;  // Invalid/Other
        endcase
    end

endmodule