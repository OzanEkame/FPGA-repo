// Debounce_tb.v - content will be filled here.
`timescale 1ns / 1ps
/*------------------------------------------------------------------------------
 * File: Debounce_tb.v
 * Module: Debounce_tb
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <your-name>
 * Last Edited: 2025-10-23 05:24 UTC
 *
 * Summary:
 *   Module description not provided. Fill in details as needed.
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/

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
// Testbench initialization / stimulus


    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end
// Testbench initialization / stimulus


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
