module gray_sync #(parameter WIDTH = 5)(
    input wire clk,
    input wire [WIDTH-1:0] d_in,
    output reg [WIDTH-1:0] d_out
);
    reg [WIDTH-1:0] q1;

    always @(posedge clk) begin
        q1 <= d_in;
        d_out <= q1;
    end
endmodule
