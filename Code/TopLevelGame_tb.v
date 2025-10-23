// TopLevelGame_tb.v - content will be filled here.
`timescale 1ns / 1ps
/*------------------------------------------------------------------------------
 * File: TopLevelGame_tb.v
 * Module: TopLevelGame_tb
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

module TopLevelGame_tb;

    reg clk;
    reg reset;
    reg [11:0] sw;
    reg btn_submit;
    wire [6:0] seg;
    wire [3:0] an;
    wire led_correct;

    TopLevelGame uut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .btn_submit(btn_submit),
        .seg(seg),
        .an(an),
        .led_correct(led_correct)
    );

    // Generate 100MHz clock
// Testbench initialization / stimulus

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
// Testbench initialization / stimulus


    initial begin
        // Initialization
        reset = 1;
        sw = 0;
        btn_submit = 0;
        #50;

        reset = 0; // Release reset
        #200;

        // Case 1: Wrong guess
        sw = 12'd8; // Guess wrong (example, 8)
        btn_submit = 1;
        #200;
        btn_submit = 0;
        #500;

        // Case 2: Correct guess
        sw = 12'd64; // Correct guess (because secret_number starts at 64)
        btn_submit = 1;
        #200;
        btn_submit = 0;
        #500;

        $finish;
    end

endmodule

  
