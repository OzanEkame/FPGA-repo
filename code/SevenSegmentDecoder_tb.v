// SevenSegmentDecoder_tb.v - content will be filled here.
`timescale 1ns / 1ps

module SevenSegmentDecoder_tb;

    reg [3:0] bcd;
    wire [6:0] seg;

    SevenSegmentDecoder uut (
        .bcd(bcd),
        .seg(seg)
    );

    initial begin
        bcd = 0;
        repeat(10) begin
            #10 bcd = bcd + 1;
        end
        #10 $finish;
    end

endmodule
