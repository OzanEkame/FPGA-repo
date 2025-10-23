// SevenSegmentDecoder_tb.v - content will be filled here.
`timescale 1ns / 1ps
/*------------------------------------------------------------------------------
 * File: SevenSegmentDecoder_tb.v
 * Module: SevenSegmentDecoder_tb
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

module SevenSegmentDecoder_tb;

    reg [3:0] bcd;
    wire [6:0] seg;

    SevenSegmentDecoder uut (
        .bcd(bcd),
        .seg(seg)
    );
// Testbench initialization / stimulus


    initial begin
        bcd = 0;
        repeat(10) begin
            #10 bcd = bcd + 1;
        end
        #10 $finish;
    end

endmodule
