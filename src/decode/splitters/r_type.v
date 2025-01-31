`timescale 1ns / 1ps

module r_type(
    input [31:0] instruction,  // 32-bit R-Type instruction
    output [6:0] opcode,       // Opcode (bits [6:0])
    output [4:0] rd,           // Destination register (bits [11:7])
    output [2:0] func3,        // Function code (bits [14:12])
    output [4:0] rs1,          // Source register 1 (bits [19:15])
    output [4:0] rs2,          // Source register 2 (bits [24:20])
    output [6:0] func7         // Function code (bits [31:25])
);

    // Assign fields based on the R-Type instruction format
    assign opcode = instruction[6:0];    // Opcode
    assign rd     = instruction[11:7];   // Destination register
    assign func3  = instruction[14:12];  // Function code (func3)
    assign rs1    = instruction[19:15];  // Source register 1
    assign rs2    = instruction[24:20];  // Source register 2
    assign func7  = instruction[31:25];  // Function code (func7)

endmodule
