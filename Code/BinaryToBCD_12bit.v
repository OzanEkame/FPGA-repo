// BinaryToBCD_12bit.v - content will be filled here.
module BinaryToBCD_12bit (
    input  [11:0] bin_in,
    output reg [3:0] thousands,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    reg [11:0] temp;

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