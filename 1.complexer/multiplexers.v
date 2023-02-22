`timescale 1ns / 1ps

module multiplexer (
	input  wire enable,
	input  wire select,
	input  wire [3:0] input_a, input_b,
	output reg  [3:0] led
);
always @(*) begin
    if(enable)
        case (select)
         1'd1:led=input_a-input_b;
         1'd0:led=input_a+input_b;
         default:led=4'b1111;
         endcase
    else led=4'b1111;
 end
endmodule
