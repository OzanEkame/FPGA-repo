# FPGA Binary Conversion Game (Verilog, 100 MHz)

A hardware logic game built on the **Xilinx Nexys A7 FPGA** using FSM control, debounced inputs, an LFSR pseudo-random generator, and Binary→BCD conversion with a multiplexed 7-segment display.

---

## Overview

The **Binary Conversion Game** displays a random decimal number on the 7-segment display.  
The player must toggle the **FPGA switches** to input its **binary equivalent**, then press the **OK button** to check their answer.  
All game logic is implemented purely in hardware with Verilog — no processors, no firmware.

---

## Features

- **Finite State Machine (FSM):** Controls game flow — *Idle → Display → Input → Check → Next*  
- **Debounce Logic:** Filters switch and button noise (synchronous at 100 MHz)  
- **LFSR PRNG:** Generates pseudo-random decimal numbers for each round  
- **Binary→BCD Conversion:** Double-dabble algorithm for decimal display output  
- **7-Segment Multiplexing:** Multi-digit scanning (~1 kHz) for stable, ghost-free display  

---

## Quick Start

1. Open the project in **Vivado** (or your preferred HDL tool).  
2. **Board:** Xilinx Nexys A7 (100 MHz clock)  
3. **Constraints:** [`constraints/board.xdc`](constraints/board.xdc) — define 100 MHz `CLK` and I/O pin map  
4. **Build → Generate bitstream → Program device**  
5. Play: the display shows a number; use the switches to input its binary equivalent and press **OK**

---

## I/O Map

| Signal | Direction | Description |
|---------|------------|-------------|
| `SW[3:0]` | Input | Binary input bits |
| `BTN_OK` | Input | Submit / Check button |
| `SEG[6:0]` | Output | 7-segment LED segments |
| `AN[n]` | Output | Digit enable lines |
| `LEDs` | Output | Optional indicators (correct/error/state) |
| `CLK` | Input | 100 MHz system clock |

---

## Design Files

| File | Description |
|------|--------------|
| [`rtl/TopLevelGame.v`](rtl/TopLevelGame.v) | Main game FSM and module integration |
| [`rtl/LFSR.v`](rtl/LFSR.v) | 16-bit pseudo-random number generator |
| [`rtl/Debounce.v`](rtl/Debounce.v) | Two-flip-flop synchronizer + integrator |
| [`rtl/BinaryToBCD_12bit.v`](rtl/BinaryToBCD_12bit.v) | Binary-to-BCD conversion (double-dabble) |
| [`rtl/DisplayMultiplexer.v`](rtl/DisplayMultiplexer.v) | 7-segment display multiplexer |
| [`rtl/SevenSegmentDecoder.v`](rtl/SevenSegmentDecoder.v) | Binary-to-7-segment code encoder |

Each module is individually verified through simulation.

---

## Simulation Testbenches

| Testbench | Purpose |
|------------|----------|
| [`sim/TopLevelGame_tb.v`](sim/TopLevelGame_tb.v) | Full game FSM and integration test |
| [`sim/Debounce_tb.v`](sim/Debounce_tb.v) | Input debounce verification |
| [`sim/BinaryToBCD_12bit_tb.v`](sim/BinaryToBCD_12bit_tb.v) | Binary→BCD conversion validation |
| [`sim/DisplayMultiplexer_tb.v`](sim/DisplayMultiplexer_tb.v) | Refresh rate and digit cycle testing |
| [`sim/SevenSegmentDecoder_tb.v`](sim/SevenSegmentDecoder_tb.v) | Segment encoding validation |

Waveform captures can be placed under `sim/waves/` for visual verification.

---

## Logic Diagram

```
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
```

---

## Notes

- Clock frequency: 100 MHz  
- Display refresh rate: ≈ 1 kHz  
- Debounce sampling window: ≈ 1 ms  
- LFSR taps configurable for maximal sequence  
- Entire design implemented in Verilog only  

---

## Demo

Add a picture of your working board here:

```
![Nexys A7 Binary Conversion Game Demo](docs/demo_photo.jpg)
```

---

## License

Released under the **MIT License**.  
Free for educational and open-source use.
