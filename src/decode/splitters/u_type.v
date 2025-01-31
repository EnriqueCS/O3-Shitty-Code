`timescale 1ns / 1ps

module u_type(
    input [31:0] instruction,  // 32-bit U-Type instruction
    output [6:0] opcode,       // Opcode (bits [6:0])
    output [4:0] rd,           // Destination register (bits [11:7])
    output [19:0] imm          // Immediate value (bits [31:12])
);

    // Assign fields based on the U-Type instruction format
    assign opcode = instruction[6:0];   // Opcode
    assign rd     = instruction[11:7];  // Destination register
    assign imm    = instruction[31:12]; // 20-bit Immediate value

endmodule
