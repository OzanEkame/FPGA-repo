`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: TopLevelGame
//////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------
 * File: TopLevelGame.v
 * Module: TopLevelGame
 * Project: FPGA Binary Conversion Game (Xilinx Nexys A7, 100 MHz system clock)
 * Author: <your-name>
 * Last Edited: 2025-10-23 05:24 UTC
 *
 * Summary:
 *   Top-level integration for the Binary Conversion Game.
- Generates a pseudo-random secret number using a free-running counter.
- Converts the secret number to BCD for 7-segment display.
- Detects rising edge on the submit button and compares switches to the secret.
- Tracks a simple difficulty level using a correct-streak counter.
 *
 * Notes:
 *   - This file has been annotated with comments for clarity.
 *   - No functional changes were made intentionally.
 *   - Verify synthesis & timing after integrating into your project.
 *----------------------------------------------------------------------------*/

module TopLevelGame(
    input clk,
    input reset,
    input [11:0] sw,
    input btn_submit,
    output [6:0] seg,
    output [7:0] an,
    output led_correct
);

    wire clk_slow;
    reg [11:0] secret_number;
    wire [3:0] thousands, hundreds, tens, ones;
    wire [3:0] selected_bcd;
    wire [6:0] seg_internal;
    reg correct;
    reg [10:0] random_counter;
    wire [10:0] random_value;

    reg [2:0] level;
    reg [10:0] max_random_limit;
    reg [1:0] correct_streak;

    // Button synchronizer
    reg btn_sync_0, btn_sync_1;
    wire submit_rising_edge;

    // Clock divider
    ClockDivider clkdiv_inst (
        .clk_in(clk),
        .rst(reset),
        .divided_clk(clk_slow)
    );

    // BCD converter for secret_number
    BinaryToBCD_12bit BCD_secret_conv (
        .bin_in(secret_number),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
    );

    // Display Multiplexer for secret number
    DisplayMultiplexer disp_mux (
        .clk(clk_slow),
        .reset(reset),
        .dig3(thousands),
        .dig2(hundreds),
        .dig1(tens),
        .dig0(ones),
        .an(an),
        .bcd_out(selected_bcd)
    );

    // 7-Segment Decoder
    SevenSegmentDecoder seg_dec (
        .bcd(selected_bcd),
        .seg(seg_internal)
    );
// Continuous assignment


    assign seg = seg_internal;

    // Random counter
// Sequential logic/process block

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            random_counter <= 0;
        end else begin
            random_counter <= random_counter + 1;
        end
    end
// Continuous assignment


    assign random_value = random_counter % 2048;

    // Button synchronizer
// Sequential logic/process block

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_sync_0 <= 0;
            btn_sync_1 <= 0;
        end else begin
            btn_sync_0 <= btn_submit;
            btn_sync_1 <= btn_sync_0;
        end
    end
// Continuous assignment


    assign submit_rising_edge = btn_sync_0 & ~btn_sync_1;

    // Secret number and level logic
// Sequential logic/process block

always @(posedge clk or posedge reset) begin
    if (reset) begin
        secret_number <= 12'd2;
        correct <= 0;
        level <= 0;
        correct_streak <= 0;
        max_random_limit <= 11'd10; // Start easy
    end else if (submit_rising_edge) begin
        if (sw == secret_number) begin
            correct <= 1;
            correct_streak <= correct_streak + 1;

            // Increase level after 3 correct guesses in a row
            if (correct_streak == 3) begin
                level <= level + 1;
                correct_streak <= 0;
            end

                // Set max random limit based on level
// Combinational case decode

    case (level)
        0: max_random_limit <= 11'd10;
        2: max_random_limit <= 11'd32;
        3: max_random_limit <= 11'd128;
        4: max_random_limit <= 11'd512;
         default: max_random_limit <= 11'd2047;
    endcase

                // Pick a new secret number within new difficulty
                secret_number <= random_value % (max_random_limit + 1);
            end else begin
                correct <= 0;
                level <= 0;
                max_random_limit <= 11'd100; // Reset difficulty
            end
        end
    end
// Continuous assignment


    assign led_correct = correct;

endmodule
