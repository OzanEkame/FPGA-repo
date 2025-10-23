// Debounce.v - content will be filled here.
module Debounce (
    input clk,
    input reset,
    input noisy_in,
    output reg clean_out
);

    reg [19:0] counter;
    reg button_sync_0, button_sync_1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            button_sync_0 <= 0;
            button_sync_1 <= 0;
        end else begin
            button_sync_0 <= noisy_in;
            button_sync_1 <= button_sync_0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clean_out <= 0;
        end else if (button_sync_1 == clean_out) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 20'd1000000) begin
                clean_out <= button_sync_1;
                counter <= 0;
            end
        end
    end

endmodule
