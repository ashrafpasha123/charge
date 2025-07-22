timescale 1ns/1ps
module tb_write_pointer;
    reg clk = 0, reset = 1, write_en = 0;
    reg [4:0] sync_rd_ptr = 5'b00000;
    wire [4:0] wr_ptr_gray;
    wire full;
    write_pointer wp (
        .clk(clk), .reset(reset), .write_en(write_en),
        .sync_rd_ptr(sync_rd_ptr),
        .wr_ptr_gray(wr_ptr_gray), .full(full)
    );
    always #5 clk = ~clk;
    initial begin
        #10 reset = 0; #10 write_en = 1;
        repeat(20) @(posedge clk); write_en = 0; #20 $stop;
    end
endmodule
