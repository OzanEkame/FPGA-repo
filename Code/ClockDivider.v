`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------
 * File: ClockDivider.v
 * Module: ClockDivider
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <Ozan Ekame Pekgoz>
 *
 * Summary:
 *   Divides the 100 MHz board clock down to a slower clock for human-visible logic (display, FSM, etc.).
Output frequency: fout = fin / (2 * (toggle_value + 1)).
Examples at 100 MHz: toggle_value=50_000 -> ~1 kHz, 500_000 -> ~100 Hz, 1_000_000 -> ~50 Hz.
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/

// Module Name:    clk_divider 

//////////////////////////////////////////////////////////////////////////////////
module clk_divider(
	input clk_in,
	input rst,
	output reg divided_clk
    );
	 
	 
parameter toggle_value = 500000; // TODO: Calculate correct value

	 
reg[32:0] cnt;
// Sequential logic/process block


always@(posedge clk_in or posedge rst)
begin
	if (rst==1) begin
		cnt <= 0;
		divided_clk <= 0;
	end
	else begin
		if (cnt==toggle_value) begin
			cnt <= 0;
			divided_clk <= ~divided_clk;
		end
		else begin
			cnt <= cnt +1;
			divided_clk <= divided_clk;		
		end
	end

end
			  
	


endmodule
