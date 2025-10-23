// BinaryToBCD_12bit_tb.v - content will be filled here.
`timescale 1ns / 1ps
/*------------------------------------------------------------------------------
 * File: BinaryToBCD_12bit_tb.v
 * Module: BinaryToBCD_12bit_tb
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <Ozan Ekame Pekgoz>
 *
 * Summary:
 *   Module description not provided. Fill in details as needed.
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/

module BinaryToBCD_12bit_tb;

    reg [11:0] bin_in;
    wire [3:0] thousands, hundreds, tens, ones;

    BinaryToBCD_12bit uut (
        .bin_in(bin_in),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
    );
// Testbench initialization / stimulus


    initial begin
        bin_in = 0;
        #10 bin_in = 12'd273;  // 273 → 0 2 7 3
        #10 bin_in = 12'd999;  // 999 → 0 9 9 9
        #10 bin_in = 12'd2048; // 2048 → 2 0 4 8
        #10 bin_in = 12'd1;    // 1 → 0 0 0 1
        #10 bin_in = 12'd1234; // 1234 → 1 2 3 4
        #10 $finish;
    end

endmodule
