module Tubes (
    input  [9:0] SW,
    input  [3:0] KEY,
    output [6:0] HEX0, HEX1,
    output [6:0] HEX2, HEX3,
    output [6:0] HEX4, HEX5
);

    wire [3:0] A = SW[3:0];
    wire [3:0] B = SW[7:4];

    reg signed [7:0] result;

    always @(*) begin
        if (!KEY[0])       // +
            result = A + B;
        else if (!KEY[1])  // -
            result = A - B;
        else if (!KEY[2])  // *
            result = A * B;
        else if (!KEY[3])  // /
            result = (B != 0) ? (A / B) : -1; // /0 → ERROR
        else
            result = 0;
    end

    // ===============================
    // ERROR DETECTION
    // ===============================
    wire error = (result < 0);

    // ===============================
    // ABSOLUTE VALUE
    // ===============================
    wire [7:0] abs_A = A;
    wire [7:0] abs_B = B;
    wire [7:0] abs_R = (result < 0) ? -result : result;

    // ===============================
    // BCD SPLIT
    // ===============================
    wire [3:0] A_tens = abs_A / 10;
    wire [3:0] A_ones = abs_A % 10;

    wire [3:0] B_tens = abs_B / 10;
    wire [3:0] B_ones = abs_B % 10;

    wire [3:0] R_tens = abs_R / 10;
    wire [3:0] R_ones = abs_R % 10;

    // ===============================
    // 7 SEGMENT CONSTANT (ACTIVE LOW)
    // ===============================
    localparam [6:0] SEG_E = 7'b0000110; // E
    localparam [6:0] SEG_r = 7'b0101111; // r

    // ===============================
    // 7 SEGMENT DISPLAY
    // ===============================
    seven_seg seg_A1 (.bcd(A_tens), .seg(HEX5));
    seven_seg seg_A0 (.bcd(A_ones), .seg(HEX4));

    seven_seg seg_B1 (.bcd(B_tens), .seg(HEX3));
    seven_seg seg_B0 (.bcd(B_ones), .seg(HEX2));

    wire [6:0] seg_R1_out;
    wire [6:0] seg_R0_out;

    seven_seg seg_R1 (.bcd(R_tens), .seg(seg_R1_out));
    seven_seg seg_R0 (.bcd(R_ones), .seg(seg_R0_out));

    // ===============================
    // RESULT / ERROR DISPLAY
    // ===============================
    assign HEX1 = error ? SEG_E : seg_R1_out;
    assign HEX0 = error ? SEG_r : seg_R0_out;

endmodule
