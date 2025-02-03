`timescale 1ns / 1ps
`ifndef DECODE_REGISTER_V
`define DECODE_REGISTER_V

module decode_register(
    input clk,                  // Clock signal to store values
    input [6:0] in_opcode,  // Opcode
    input [1:0] in_group,   // Instruction group
    input in_specifier,     // Specifier bit
    input [2:0] in_funct3,  // Funct3
    input [6:0] in_funct7,  // Funct7
    input [4:0] in_rs1,     // Source register 1
    input [4:0] in_rs2,     // Source register 2
    input [4:0] in_rd,      // Destination register
    input [20:0] in_imm20,
    
    output reg [6:0] out_opcode,
    output reg [1:0] out_group,
    output reg out_specifier,
    output reg [2:0] out_funct3,
    output reg [6:0] out_funct7,
    output reg [4:0] out_rs1,
    output reg [4:0] out_rs2,
    output reg [4:0] out_rd,
    output reg [20:0] out_imm20
);

    always @(posedge clk) begin
        out_opcode   <= in_opcode;
        out_group    <= in_group;
        out_specifier <= in_specifier;
        out_funct3   <= in_funct3;
        out_funct7   <= in_funct7;
        out_rs1      <= in_rs1;
        out_rs2      <= in_rs2;
        out_rd       <= in_rd;
        out_imm20    <= in_imm20;
    end

endmodule

`endif // DECODE_REGISTER_V
