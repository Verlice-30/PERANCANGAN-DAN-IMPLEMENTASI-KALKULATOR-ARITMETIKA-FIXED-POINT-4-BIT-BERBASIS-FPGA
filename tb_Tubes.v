module tb_Tubes;

    reg  [9:0] SW;
    reg  [3:0] KEY;

    wire [6:0] HEX0, HEX1;
    wire [6:0] HEX2, HEX3;
    wire [6:0] HEX4, HEX5;

    Tubes dut (
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    initial begin

        SW  = 10'b0;
        KEY = 4'b1111;
        #10;

        SW[3:0] = 4'd5;   // A
        SW[7:4] = 4'd3;   // B
        KEY     = 4'b1110; // KEY[0] = 0 (ADD)
        #10;

        SW[3:0] = 4'd3;
        SW[7:4] = 4'd5;
        KEY     = 4'b1101; // KEY[1] = 0 (SUB)
        #10;

        SW[3:0] = 4'd4;
        SW[7:4] = 4'd2;
        KEY     = 4'b1011; // KEY[2] = 0 (MUL)
        #10;

        SW[3:0] = 4'd9;
        SW[7:4] = 4'd3;
        KEY     = 4'b0111; // KEY[3] = 0 (DIV)
        #10;

        SW[3:0] = 4'd7;
        SW[7:4] = 4'd0;
        KEY     = 4'b0111; // DIV
        #10;

        SW[3:0] = 4'd15;
        SW[7:4] = 4'd1;
        KEY     = 4'b1110; // ADD
        #10;

        $stop;
    end

endmodule
