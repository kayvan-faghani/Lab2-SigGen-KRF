module sinegen #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    input logic     clk,
    input logic     rst,
    input logic     en,
    input logic [D_WIDTH-1:0] incr,
    output logic [D_WIDTH-1:0] dout1,
    output logic [D_WIDTH-1:0] dout2
);

logic [A_WIDTH-1:0] address1;


counter counter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address1)
);

rom sinerom (
    .clk(clk),
    .addr1 (address1),
    .addr2 (address1+incr),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule
