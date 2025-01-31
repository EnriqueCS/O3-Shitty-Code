`timescale 1ns / 1ps

module i_type(
    input [31:0] instruction,  // 32-bit I-Type instruction
    output [6:0] opcode,       // Opcode (bits [6:0])
    output [4:0] rd,           // Destination register (bits [11:7])
    output [2:0] func3,        // Function code (bits [14:12])
    output [4:0] rs1,          // Source register 1 (bits [19:15])
    output [11:0] imm          // Immediate value (bits [31:20])
);

    // Assign fields based on the I-Type instruction format
    assign opcode = instruction[6:0];    // Opcode
    assign rd     = instruction[11:7];   // Destination register
    assign func3  = instruction[14:12];  // Function code (func3)
    assign rs1    = instruction[19:15];  // Source register 1
    assign imm    = instruction[31:20];  // Immediate value

endmodule
