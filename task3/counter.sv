module counter #(
    parameter WIDTH = 9
)(
    input logic clk,
    input logic rst, 
    input logic en,
    input logic [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] count
);

always @ (posedge clk, posedge rst)
    if (rst)
        count <= {WIDTH{1'b0}};
    else if(en) 
        count <= count + incr;

endmodule
