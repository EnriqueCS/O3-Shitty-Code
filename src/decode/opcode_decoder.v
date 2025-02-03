`timescale 1ns / 1ps
`ifndef OPCODE_DECODER_V
`define OPCODE_DECODER_V

module opcode_decoder(
    input [31:0] instruction,   // 32-bit RISC-V instruction
    output reg [1:0] group,     // 2-bit group ID
    output reg specifier,       // 1-bit specifier
    output reg [24:0] instruction_data, // 25-bit instruction data (everything except opcode)
    output reg [6:0] opcode_out // 7-bit opcode
);

    always @(*) begin
        opcode_out = instruction[6:0];       // Extract opcode
        instruction_data = instruction[31:7]; // Remaining 25 bits

        // Grouping logic based on opcode
        case (opcode_out)
            7'b0110011, // R-Type
            7'b0010011, // I-Type (ALU immediate)
            7'b0000011, // I-Type (Load)
            7'b1100111: // I-Type (JALR)
            begin
                group = 2'b01;
                specifier = (opcode_out == 7'b0110011) ? 1'b0 : 1'b1;
            end

            7'b0100011, // S-Type (Store)
            7'b1100011: // B-Type (Branch)
            begin
                group = 2'b10;
                specifier = (opcode_out == 7'b0100011) ? 1'b0 : 1'b1;
            end

            7'b0110111, // U-Type (LUI)
            7'b0010111, // U-Type (AUIPC)
            7'b1101111: // J-Type (JAL)
            begin
                group = 2'b11;
                specifier = (opcode_out == 7'b1101111) ? 1'b0 : 1'b1;
            end

            default: begin
                group = 2'b00; // Invalid/Other
                specifier = 1'b0;
            end
        endcase
    end

endmodule

`endif // OPCODE_DECODER_V