module read_pointer #(parameter ADDR_WIDTH = 4)(
    input wire clk, reset, read_en,
    input wire [ADDR_WIDTH:0] sync_wr_ptr,
    output reg [ADDR_WIDTH:0] rd_ptr_gray,
    output wire empty
);
    reg [ADDR_WIDTH:0] rd_ptr_bin;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rd_ptr_bin <= 0;
            rd_ptr_gray <= 0;
        end else if (read_en && !empty) begin
            rd_ptr_bin <= rd_ptr_bin + 1;
            rd_ptr_gray <= (rd_ptr_bin >> 1) ^ rd_ptr_bin;
        end
    end

    assign empty = (rd_ptr_gray == sync_wr_ptr);
endmodule
