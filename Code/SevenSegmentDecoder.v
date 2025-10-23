// SevenSegmentDecoder.v - content will be filled here.
/*------------------------------------------------------------------------------
 * File: SevenSegmentDecoder.v
 * Module: SevenSegmentDecoder
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <Ozan Ekame Pekgoz>
 *
 * Summary:
 *   Maps a 4-bit BCD digit (0–9) to active-low 7-segment patterns `SEG[6:0]`.
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/
module SevenSegmentDecoder (
    input  [3:0] bcd,
    output reg [6:0] seg
);
// Sequential logic/process block


    always @(*) begin
// Combinational case decode

        case (bcd)
            4'b0000: seg = 7'b0000001;
            4'b0001: seg = 7'b1001111;
            4'b0010: seg = 7'b0010010;
            4'b0011: seg = 7'b0000110;
            4'b0100: seg = 7'b1001100;
            4'b0101: seg = 7'b0100100;
            4'b0110: seg = 7'b0100000;
            4'b0111: seg = 7'b0001111;
            4'b1000: seg = 7'b0000000;
            4'b1001: seg = 7'b0000100;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
