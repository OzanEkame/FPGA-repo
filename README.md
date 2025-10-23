FPGA Binary Conversion Game (Verilog, 100 MHz)

A hardware logic game built on the Xilinx Nexys A7 FPGA using FSM control, debounced inputs, an LFSR pseudo-random generator, and Binary→BCD conversion with a multiplexed 7-segment display.

Overview

The Binary Conversion Game displays a random decimal number on the 7-segment display.
The player must toggle the FPGA switches to input its binary equivalent, then press the OK button to check their answer.
All game logic is handled purely in hardware with Verilog—no processors, no firmware.

Features

Finite State Machine (FSM): Controls game flow — Idle → Display → Input → Check → Next

Debounce Logic: Filters switch and button noise (synchronous at 100 MHz)

LFSR PRNG: Generates pseudo-random decimal numbers for each round

Binary→BCD Conversion: Double-dabble algorithm for decimal output

7-Segment Multiplexing: Multi-digit scanning (~1 kHz) for stable, ghost-free display

Quick Start

Open the project in Vivado (or your preferred HDL tool).

Board: Xilinx Nexys A7 (100 MHz clock)

Constraints: constraints/board.xdc (define 100 MHz CLK and I/O pin map).

Build → Generate bitstream → Program device.

Play: the display shows a number; use switches to input its binary equivalent and press OK.

I/O Map
Signal	    Direction	     Description
SW[3:0]	    Input	         Binary input bits 
BTN_OK	    Input	         Submit/check button
SEG[6:0]	  Output	       7-segment LED segments
AN[n]	      Output	       Digit enable lines
LEDs	      Output	       Optional indicators (correct/error/state)
CLK	        Input	         100 MHz system clock

Design Files
File	                  Description
TopLevelGame.v	        Main game FSM and module integration    
LFSR.v	                16-bit pseudo-random number generator   
Debounce.v	            Two-flip-flop synchronizer + integrator
BinaryToBCD_12bit.v	    Binary-to-BCD conversion (double-dabble)
DisplayMultiplexer.v    7-segment display multiplexer
SevenSegmentDecoder.v 	Binary to 7-segment code encoder

All core modules are tested and verified through simulation.

Simulation Files
Testbench	                Purpose
TopLevelGame_tb.v	        Game FSM and integration test
Debounce_tb.v	            Debounce behavior verification
BinaryToBCD_12bit_tb.v	  Conversion validation
DisplayMultiplexer_tb.v	  Refresh and digit cycle testing
SevenSegmentDecoder_tb.v	Segment pattern verification

Waveform results can be viewed in /sim/waves/.

Logic Diagram
+--------------------+
|    LFSR (Random)   |
+---------+----------+
          |
          v
   +------+------+
   |   FSM Logic  |  <-- Debounced inputs
   +------+------+
          |
          v
+---------+----------+
| BinaryToBCD_12bit  |
+---------+----------+
          |
          v
  +-------+-------+
  | Display MUX   |
  +-------+-------+
          |
          v
  +-------+-------+
  |  7-Segment LED |
  +---------------+

Notes

Clock frequency: 100 MHz

Display refresh rate: ~1 kHz

Debounce sampling window: ~1 ms

LFSR taps configurable for maximal sequence

Entire design implemented in Verilog — no soft-core or CPU logic

License

Released under the MIT License.
Free for educational and open-source use.

Demo

Add a picture of your working board here once ready:

![Nexys A7 Binary Conversion Game Demo](docs/demo_photo.jpg)
