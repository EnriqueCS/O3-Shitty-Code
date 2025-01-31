`timescale 1ns / 1ps

module b_type(
    input [31:0] instruction,  // 32-bit B-Type instruction
    output [6:0] opcode,       // Opcode (bits [6:0])
    output [4:0] rs1,          // Source register 1 (bits [19:15])
    output [4:0] rs2,          // Source register 2 (bits [24:20])
    output [2:0] func3,        // Function code (bits [14:12])
    output [12:0] imm          // Immediate value (bits [31:31], [7:7], [30:25], [11:8])
);

    // Assign fields based on the B-Type instruction format
    assign opcode = instruction[6:0];  // Opcode
    assign rs1    = instruction[19:15]; // Source register 1
    assign rs2    = instruction[24:20]; // Source register 2
    assign func3  = instruction[14:12]; // Function code (func3)
    assign imm    = {instruction[31],   // imm[12] (sign bit)
                     instruction[7],    // imm[11]
                     instruction[30:25], // imm[10:5]
                     instruction[11:8], // imm[4:1]
                     1'b0};             // imm[0] (always 0 for alignment)

endmodule
