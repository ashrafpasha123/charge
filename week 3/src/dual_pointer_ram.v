module dual_port_ram #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 4)(
    input wire clk_a, clk_b,
    input wire we_a, we_b,
    input wire [ADDR_WIDTH-1:0] addr_a, addr_b,
    input wire [DATA_WIDTH-1:0] din_a, din_b,
    output reg [DATA_WIDTH-1:0] dout_a, dout_b
);
    reg [DATA_WIDTH-1:0] mem [(1<<ADDR_WIDTH)-1:0];

    always @(posedge clk_a) begin
        if (we_a) mem[addr_a] <= din_a;
        dout_a <= mem[addr_a];
    end

    always @(posedge clk_b) begin
        if (we_b) mem[addr_b] <= din_b;
        dout_b <= mem[addr_b];
    end
endmodule
