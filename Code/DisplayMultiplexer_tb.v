// DisplayMultiplexer_tb.v - content will be filled here.
`timescale 1ns / 1ps

module DisplayMultiplexer_tb;

    reg clk;
    reg reset;
    reg [3:0] dig3, dig2, dig1, dig0;
    wire [3:0] an;
    wire [3:0] bcd_out;

    DisplayMultiplexer uut (
        .clk(clk),
        .reset(reset),
        .dig3(dig3),
        .dig2(dig2),
        .dig1(dig1),
        .dig0(dig0),
        .an(an),
        .bcd_out(bcd_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    initial begin
        reset = 1;
        dig3 = 4'd1;
        dig2 = 4'd2;
        dig1 = 4'd3;
        dig0 = 4'd4;
        #20 reset = 0;
        #500000 $finish;
    end

endmodule
