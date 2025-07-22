`timescale 1ns/1ps
module tb_read_pointer;
    reg clk = 0, reset = 1, read_en = 0;
    reg [4:0] sync_wr_ptr = 5'b00000;
    wire [4:0] rd_ptr_gray;
    wire empty;
    read_pointer rp (
        .clk(clk), .reset(reset), .read_en(read_en),
        .sync_wr_ptr(sync_wr_ptr),
        .rd_ptr_gray(rd_ptr_gray), .empty(empty)
    );
    always #5 clk = ~clk;
    initial begin
        #10 reset = 0; #10 read_en = 1;
        repeat(20) @(posedge clk); read_en = 0; #20 $stop;
    end
endmodule
