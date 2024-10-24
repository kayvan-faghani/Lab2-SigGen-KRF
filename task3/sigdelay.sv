module sigdelay #(
    parameter A_WIDTH = 9,
              D_WIDTH = 8
)(
    input logic     clk,
    input logic     rst,
    input logic     en,
    input logic     wr_en,
    input logic     rd_en,
    input logic [A_WIDTH-1:0] offset,
    input logic [D_WIDTH-1:0] mic_signal,
    output logic [A_WIDTH-1:0]current_address,
    output logic [D_WIDTH-1:0] delayed_signal
);

logic [A_WIDTH-1:0] address;
assign current_address = address;
counter counter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (address)
);

ram voiceram (
    .clk(clk),
    .rd_en (rd_en),
    .wr_en (wr_en),
    .rd_addr (address),
    .wr_addr (address+offset),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule
