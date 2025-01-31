`timescale 1ns / 1ps

module j_type(
    input [31:0] instruction,  // 32-bit J-Type instruction
    output [6:0] opcode,       // Opcode (bits [6:0])
    output [4:0] rd,           // Destination register (bits [11:7])
    output [20:0] imm          // Immediate value (bits [31] + [19:12] + [20] + [30:21])
);

    // Assign fields based on the J-Type instruction format
    assign opcode = instruction[6:0];   // Opcode
    assign rd     = instruction[11:7];  // Destination register
    assign imm    = {instruction[31],   // imm[20] (sign bit)
                     instruction[19:12],// imm[19:12]
                     instruction[20],   // imm[11]
                     instruction[30:21],// imm[10:1]
                     1'b0};             // imm[0] (always 0 for alignment)

endmodule
