`timescale 1ns/1ps

module tb_async_fifo;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 4;

  reg wr_clk = 0;
  reg rd_clk = 0;
  reg rst = 1;

  reg wr_en = 0;
  reg rd_en = 0;
  reg [DATA_WIDTH-1:0] din = 0;

  wire [DATA_WIDTH-1:0] dout;
  wire full, empty;

  // Instantiate the FIFO
  async_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) uut (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

  // Clock generation
  always #5 wr_clk = ~wr_clk;   // 100 MHz write clock
  always #7 rd_clk = ~rd_clk;   // ~71 MHz read clock

  initial begin
    $display("Starting FIFO Test...");
    #20 rst = 0;

    // Test 1: Write until full
    repeat (20) begin
      @(posedge wr_clk);
      if (!full) begin
        wr_en <= 1;
        din <= din + 1;
        $display("Write: %0d", din);
      end else begin
        wr_en <= 0;
        $display("FIFO Full");
      end
    end
    wr_en <= 0;

    // Test 2: Read until empty
    repeat (20) begin
      @(posedge rd_clk);
      if (!empty) begin
        rd_en <= 1;
        $display("Read: %0d", dout);
      end else begin
        rd_en <= 0;
        $display("FIFO Empty");
      end
    end
    rd_en <= 0;

    // Test 3: Overflow Prevention
    $display("Testing overflow prevention...");
    repeat (20) begin
      @(posedge wr_clk);
      wr_en <= 1;
      din <= $random;
    end
    wr_en <= 0;

    // Test 4: Underflow Prevention
    $display("Testing underflow prevention...");
    repeat (20) begin
      @(posedge rd_clk);
      rd_en <= 1;
    end
    rd_en <= 0;

    #100 $finish;
  end
endmodule
