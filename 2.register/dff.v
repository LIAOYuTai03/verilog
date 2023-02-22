module dff(
	input wire clk,
	input wire clr,
	input wire en,
	input wire[7:0] d,
	output reg [7:0]q
);

always @(posedge clk or posedge clr)
begin
if (clr == 1'b1) q<=8'b0;
else if (en == 1'b1) q<=d;
end

endmodule