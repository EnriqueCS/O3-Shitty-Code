module four_inputs (
    input wire v1,
    input wire v2,
    input wire v3,
    input wire v4,
    output wire result
);

// Logic: result = (v1 AND v2) OR (v3 AND v4)
assign result = (v1 & v2) | (v3 & v4);

endmodule