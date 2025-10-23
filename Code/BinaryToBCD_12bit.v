// BinaryToBCD_12bit.v - content will be filled here.
/*------------------------------------------------------------------------------
 * File: BinaryToBCD_12bit.v
 * Module: BinaryToBCD_12bit
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <Ozan Ekame Pekgoz>
 *
 * Summary:
 *   Converts a 12-bit binary value into four BCD digits (thousands, hundreds, tens, ones).
This version uses integer division/modulo (synthesizable on most tools; check resource usage).
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/
module BinaryToBCD_12bit (
    input  [11:0] bin_in,
    output reg [3:0] thousands,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    reg [11:0] temp;
// Sequential logic/process block


    always @(*) begin
        temp = bin_in;
        thousands = temp / 1000;
        temp = temp % 1000;
        hundreds  = temp / 100;
        temp = temp % 100;
        tens = temp / 10;
        temp = temp % 10;
        ones = temp;
    end

endmodule
