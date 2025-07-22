module write_pointer #(parameter ADDR_WIDTH = 4)(
    input wire clk, reset, write_en,
    input wire [ADDR_WIDTH:0] sync_rd_ptr,
    output reg [ADDR_WIDTH:0] wr_ptr_gray,
    output wire full
);
    reg [ADDR_WIDTH:0] wr_ptr_bin;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr_bin <= 0;
            wr_ptr_gray <= 0;
        end else if (write_en && !full) begin
            wr_ptr_bin <= wr_ptr_bin + 1;
            wr_ptr_gray <= (wr_ptr_bin >> 1) ^ wr_ptr_bin;
        end
    end
    assign full = (wr_ptr_gray == {~sync_rd_ptr[ADDR_WIDTH:ADDR_WIDTH-1], sync_rd_ptr[ADDR_WIDTH-2:0]});
endmodule
