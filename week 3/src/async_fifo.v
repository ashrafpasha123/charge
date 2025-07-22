module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input wire wr_clk, rd_clk, rst,
    input wire wr_en, rd_en,
    input wire [DATA_WIDTH-1:0] din,
    output wire [DATA_WIDTH-1:0] dout,
    output wire full, empty
);

    wire [ADDR_WIDTH:0] wr_ptr_gray, rd_ptr_gray;
    wire [ADDR_WIDTH:0] wr_ptr_bin, rd_ptr_bin;
    wire [ADDR_WIDTH:0] sync_rd_ptr, sync_wr_ptr;

    // Dual-port RAM
    dual_port_ram #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) ram (
        .clk_a(wr_clk), .clk_b(rd_clk),
        .we_a(wr_en && !full), .we_b(1'b0),
        .addr_a(wr_ptr_bin[ADDR_WIDTH-1:0]), .addr_b(rd_ptr_bin[ADDR_WIDTH-1:0]),
        .din_a(din), .din_b({DATA_WIDTH{1'b0}}),
        .dout_a(), .dout_b(dout)
    );

    // Write pointer logic
    write_pointer #(.ADDR_WIDTH(ADDR_WIDTH)) wp (
        .clk(wr_clk), .reset(rst), .write_en(wr_en),
        .sync_rd_ptr(sync_rd_ptr),
        .wr_ptr_gray(wr_ptr_gray), .full(full)
    );

    // Read pointer logic
    read_pointer #(.ADDR_WIDTH(ADDR_WIDTH)) rp (
        .clk(rd_clk), .reset(rst), .read_en(rd_en),
        .sync_wr_ptr(sync_wr_ptr),
        .rd_ptr_gray(rd_ptr_gray), .empty(empty)
    );

    // Pointer synchronizers
    gray_sync #(.WIDTH(ADDR_WIDTH+1)) sync_wr2rd (
        .clk(rd_clk), .d_in(wr_ptr_gray), .d_out(sync_wr_ptr)
    );

    gray_sync #(.WIDTH(ADDR_WIDTH+1)) sync_rd2wr (
        .clk(wr_clk), .d_in(rd_ptr_gray), .d_out(sync_rd_ptr)
    );

endmodule
