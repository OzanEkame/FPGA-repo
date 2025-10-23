// DisplayMultiplexer.v - content will be filled here.
module DisplayMultiplexer (
    input clk,          // 25MHz clock
    input reset,
    input [3:0] dig3,   // Thousands
    input [3:0] dig2,   // Hundreds
    input [3:0] dig1,   // Tens
    input [3:0] dig0,   // Ones
    output reg [7:0] an,  // Anodes (active low)
    output reg [3:0] bcd_out
);

    reg [1:0] display_digit;

    always @(posedge clk or posedge reset) begin
        if (reset)
            display_digit <= 0;
        else
            display_digit <= display_digit + 1;
    end

    always @(*) begin
        case(display_digit)
            2'b00: begin
                an = 8'b11110111; // Activate LED3 (leftmost)
                bcd_out = dig3;   // Thousands place
            end
            2'b01: begin
                an = 8'b11111011; // Activate LED2
                bcd_out = dig2;   // Hundreds place
            end
            2'b10: begin
                an = 8'b11111101; // Activate LED1
                bcd_out = dig1;   // Tens place
            end
            2'b11: begin
                an = 8'b11111110; // Activate LED0 (rightmost)
                bcd_out = dig0;   // Ones place
            end
            default: begin
                an = 8'b11111111; // All OFF
                bcd_out = 4'b0000;
            end
        endcase
    end

endmodule

