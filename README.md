# FPGA Binary-Conversion Game (Verilog, 100 MHz)

A hardware game on FPGA using **FSM logic**, **debounced inputs**, **LFSR pseudo-random prompts**, and **Binary→BCD** with **multiplexed 7-segment display**.

## Features
- Finite State Machine: Idle → Prompt → Input → Check → Score/Timeout → Next
- **Debounce** for buttons/switches (synchronous, 100 MHz)
- **LFSR PRNG** (taps: [fill taps]) to generate random target numbers
- **Binary→BCD** conversion (double-dabble) for score/time output
- **7-segment multiplexing** (N digits @ ~1 kHz refresh, no ghosting)

## Quick Start
1. Open project in **Vivado** (or your tool).
2. Board: [FPGA board name].
3. Constraints: `constraints/board.xdc` (100 MHz `CLK`, pin map).
4. Build → Program device.

## I/O Map
- Inputs: BTN_UP (increment), BTN_OK (submit), SW[3:0] (answer bits)
- Outputs: SEG[6:0], AN[n], LEDs (state, life, or error)
- Clock: 100 MHz

## Design
- `rtl/fsm.sv` — game states & timers  
- `rtl/debounce.sv` — 2-FF sync + integrator  
- `rtl/lfsr.sv` — 16-bit LFSR PRNG (seedable)  
- `rtl/bin2bcd.sv` — binary to BCD for 7-segment  
- `rtl/sevenseg_mux.sv` — digit scan & segment encode

## Simulation
- `sim/tb_fsm.sv`, `sim/tb_debounce.sv`, `sim/tb_lfsr.sv`
- Waveforms: `sim/waves/…` (screenshots in `docs/`)

## Screens & Demo
- ![Board](docs/board.jpg)
- ![Waveform](docs/wave_prng.png)
- ![7-seg](docs/sevenseg.gif)

## Notes
- Clock: **100 MHz** (divide as needed for 1 kHz display mux & button sampling).
- LFSR taps: [list taps]; period 2^N−1 when nonzero seed.
