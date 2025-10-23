// Debounce_tb.v - content will be filled here.
`timescale 1ns / 1ps

module Debounce_tb;

    reg clk;
    reg reset;
    reg noisy_in;
    wire clean_out;

    Debounce uut (
        .clk(clk),
        .reset(reset),
        .noisy_in(noisy_in),
        .clean_out(clean_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    initial begin
        reset = 1;
        noisy_in = 0;
        #20 reset = 0;
        #20 noisy_in = 1; // simulate a bounce
        #30 noisy_in = 0;
        #40 noisy_in = 1;
        #100000 $finish;
    end

endmodule


endmodule
