`timescale 1ns / 1ps
module sequence_detection_sim();

reg clk,rst,button;
reg[7:0] switch;
wire led;

sequence_detection u_sequence_detection(.clk(clk),.rst(rst),.button(button),.switch(switch),.led(led));

initial
begin
clk=1'b1;rst=1'b1;button=1'b0;switch=8'b00000000;
#4 button = 1'b1;rst=1'b0; switch = 8'b00011010;
#1 button = 1'b0;
#20 switch = 8'b00110111;
#19 button = 1'b1;
#1 button = 1'b0;
#20 $finish;
end

always #1 clk=~clk;
endmodule
