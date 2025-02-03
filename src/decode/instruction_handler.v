`timescale 1ns / 1ps
`include "instruction_common_fields.v"
`include "opcode_decoder.v"
`include "imm_extractor.v"
`include "imm_concatenator.v"
`include "decode_register.v"

`ifndef INSTRUCTION_HANDLER_V
`define INSTRUCTION_HANDLER_V

module instruction_handler(
    input  clk,                   // Clock for decode register
    input  [31:0] instruction,    // 32-bit instruction input
    output reg [31:0] imm_value   // Sign-extended immediate (final)
);

    //-------------------------------------------------------------
    // 1) Decode the opcode, group, specifier, and raw bits
    //-------------------------------------------------------------
    wire [1:0]  group;
    wire        specifier;
    wire [24:0] instruction_data;
    wire [6:0]  opcode_out;

    opcode_decoder decoder (
        .instruction      (instruction),
        .group            (group),
        .specifier        (specifier),
        .instruction_data (instruction_data),
        .opcode_out       (opcode_out)
    );

    //-------------------------------------------------------------
    // 2) Common fields (R/I/S/B) via instruction_common_fields
    //-------------------------------------------------------------
    wire [4:0] rs1_common, rs2_common, rd_common;
    wire [2:0] funct3_common;
    wire [6:0] funct7_common;
    wire [11:0] imm_i12_common;
    wire [6:0]  imm_s7_common, imm_b7_common;
    wire [4:0]  imm_s5_common, imm_b5_common;

    instruction_common_fields common_fields (
        .instruction_data (instruction_data),
        .group            (group),
        .specifier        (specifier),

        // Basic fields
        .rs1     (rs1_common),
        .funct3  (funct3_common),
        .funct7  (funct7_common),
        .rs2     (rs2_common),
        .rd      (rd_common),

        // Immediate subfields
        .imm_i12 (imm_i12_common),
        .imm_s7  (imm_s7_common),
        .imm_s5  (imm_s5_common),
        .imm_b7  (imm_b7_common),
        .imm_b5  (imm_b5_common)
    );

    //-------------------------------------------------------------
    // 3) U/J immediate extraction via imm_extractor
    //-------------------------------------------------------------
    // imm_extractor handles group=11 => U/J 
    wire [20:0] imm_uj;
    wire [4:0]  rd_uj;

    imm_extractor imm_ext (
        .instruction_data (instruction_data),
        .specifier        (specifier), // 0 => U, 1 => J
        .imm              (imm_uj),
        .rd               (rd_uj)
    );

    //-------------------------------------------------------------
    // 4) Concatenate sub-immediates into a single 21-bit bus 
    //    using the new imm_concatenator module
    //-------------------------------------------------------------
    wire [20:0] imm_out;
    wire use_uj_rd;

    imm_concatenator imm_mux (
        .group(group),
        .specifier(specifier),

        // R/I => imm_i12; S => imm_s7/s5; B => imm_b7/b5
        .imm_i12(imm_i12_common),
        .imm_s7 (imm_s7_common),
        .imm_s5 (imm_s5_common),
        .imm_b7 (imm_b7_common),
        .imm_b5 (imm_b5_common),

        // U/J => imm_uj
        .imm_uj (imm_uj),

        // Outputs
        .imm_out(imm_out),
        .use_uj_rd(use_uj_rd)
    );

    //-------------------------------------------------------------
    // 5) Decide which `rd` to use (R/I/S/B => rd_common, U/J => rd_uj)
    //-------------------------------------------------------------
    reg [4:0]  rd_selected;
    always @(*) begin
        if (use_uj_rd == 1'b1) begin
            rd_selected = rd_uj;
        end else begin
            rd_selected = rd_common;
        end
    end

    //-------------------------------------------------------------
    // 6) Send everything into the decode register
    //-------------------------------------------------------------
    wire [6:0] reg_opcode;
    wire [1:0] reg_group;
    wire       reg_specifier;
    wire [2:0] reg_funct3;
    wire [6:0] reg_funct7;
    wire [4:0] reg_rs1, reg_rs2, reg_rd;
    wire [20:0] reg_imm20; // 21 bits

    decode_register decode_reg (
        .clk         (clk),
        .in_opcode   (opcode_out),
        .in_group    (group),
        .in_specifier(specifier),
        .in_funct3   (funct3_common),
        .in_funct7   (funct7_common),
        .in_rs1      (rs1_common),
        .in_rs2      (rs2_common),
        .in_rd       (rd_selected), // The chosen rd
        .in_imm20    (imm_out),     // Unified immediate

        // Outputs
        .out_opcode  (reg_opcode),
        .out_group   (reg_group),
        .out_specifier(reg_specifier),
        .out_funct3  (reg_funct3),
        .out_funct7  (reg_funct7),
        .out_rs1     (reg_rs1),
        .out_rs2     (reg_rs2),
        .out_rd      (reg_rd),
        .out_imm20   (reg_imm20)
    );

    //-------------------------------------------------------------
    // 7) (Optional) Sign-extend or zero-extend reg_imm20 to 32 bits
    //-------------------------------------------------------------
    always @(*) begin
        imm_value = 32'b0;

        case (reg_group)
            // R / I
            2'b01: begin
                if (reg_specifier) begin
                    // I => sign-extend from bit [20]
                    imm_value = {{11{reg_imm20[20]}}, reg_imm20};
                end else begin
                    // R => no immediate
                    imm_value = 32'b0;
                end
            end

            // S / B
            2'b10: begin
                // sign-extend from bit [20]
                imm_value = {{11{reg_imm20[20]}}, reg_imm20};
            end

            // U / J
            2'b11: begin
                // Typically U is zero- or sign-extended differently; J is sign-extended
                // Here we sign-extend from bit [20], but you can adjust.
                imm_value = {{11{reg_imm20[20]}}, reg_imm20};
            end

            default: imm_value = 32'b0;
        endcase
    end

endmodule

`endif // INSTRUCTION_HANDLER_V
