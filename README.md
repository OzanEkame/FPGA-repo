# FPGA Binary Conversion Game (Verilog, 100 MHz)

A hardware logic game built on the **Xilinx Nexys A7 FPGA**, using FSM control, debounced inputs, random number generation, and Binary→BCD display conversion on a multiplexed 7-segment display.

---

## Overview

The **Binary Conversion Game** displays a random decimal number on the 7-segment display.  
The player uses the **FPGA switches** to enter its **binary equivalent**, then presses the **OK button** to submit.  
If correct, the board lights an indicator LED and advances the difficulty level.  
All logic is implemented purely in **Verilog** — no processors or firmware.

---

## Features

- **Finite-State Machine:** Manages game flow, random generation, and level progression  
- **Random Number Generation:** Counter-based pseudo-random selection up to 2048  
- **Difficulty Scaling:** Expands the random range as the player succeeds  
- **Debounce Filter:** Hardware-level input stabilization for switches and buttons  
- **Binary→BCD Conversion:** Integer division approach for decimal display digits  
- **7-Segment Multiplexing:** Time-division display driving at ≈ 1 kHz refresh  
- **Visual Feedback:** LED indicator lights when the submitted answer is correct  

---

## Quick Start

1. **Open Project:** Launch in *Vivado* (or any preferred HDL tool).  
2. **Board:** Xilinx Nexys A7 (100 MHz clock).  
3. **Constraints:** [`constraints/board.xdc`](constraints/board.xdc) — define 100 MHz `CLK` and I/O pins.  
4. **Build → Generate Bitstream → Program Device.**  
5. **Play:** The display shows a number; set the switches to its binary equivalent and press OK.  

---

## I/O Map

| Signal | Direction | Description |
|:--|:--|:--|
| `SW[11:0]` | Input | Binary input bits |
| `BTN_SUBMIT` | Input | Submit / Check button |
| `SEG[6:0]` | Output | 7-segment LED segments |
| `AN[7:0]` | Output | Digit enable lines |
| `LED_CORRECT` | Output | Indicator for correct answer |
| `CLK` | Input | 100 MHz system clock |

---

## Design Files

| File | Description |
|:--|:--|
| [`TopLevelGame.v`](Code/TopLevelGame.v) | Main game logic – FSM, random generation, level control, LED feedback |
| [`BinaryToBCD_12bit.v`](Code/BinaryToBCD_12bit.v) | Binary-to-BCD conversion for display |
| [`Debounce.v`](Code/Debounce.v) | Button and switch debouncing logic |
| [`DisplayMultiplexer.v`](Code/DisplayMultiplexer.v) | Digit scanner for multiplexed 7-segment output |
| [`SevenSegmentDecoder.v`](Code/SevenSegmentDecoder.v) | BCD digit to 7-segment encoding |
| [`ClockDivider.v`](Code\clk_divider.v) | Clock divider for slow display refresh |

---

## Simulation Testbenches

| Testbench | Purpose |
|:--|:--|
| [`BinaryToBCD_12bit_tb.v`](Code/BinaryToBCD_12bit_tb.v) | Validates Binary→BCD conversion |
| [`DisplayMultiplexer_tb.v`](Code/DisplayMultiplexer_tb.v) | Tests digit scanning and refresh rate |
| [`SevenSegmentDecoder_tb.v`](Code/SevenSegmentDecoder_tb.v) | Verifies segment encoding for 0–9 |
| [`TopLevelGame_tb.v`](Code/TopLevelGame_tb.v) | Simulates entire game logic integration |

---

## Logic Diagram

```
+--------------------+
|   Random Counter   |
+---------+----------+
          |
          v
   +------+------ +
   |   Game FSM   | <-- Debounced button input
   +------+------ +
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
  | 7-Segment LED |
  +---------------+
```

---

## Notes

- Clock frequency: 100 MHz  
- Display refresh: ≈ 1 kHz  
- Debounce delay: ≈ 1 ms  
- Maximum range: up to 12-bit (4095)  
- All modules written in Verilog  

---

## Demo



```
![Nexys A7 Binary Conversion Game Demo](docs/demo_photo.jpg)
```

---

## License

Released under the **MIT License**.  
Free for educational and open-source use.
