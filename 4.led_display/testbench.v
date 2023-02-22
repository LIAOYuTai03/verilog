`timescale 1ns / 1ps

module testbench_sim();

reg rst,button,clk,counter;
wire[7:0] led_en;
wire[6:0] led;

led_display_ctr u_led_display_ctr(.rst(rst),.button(button),.clk(clk),.counter(counter),.led_en(led_en),.led(led));

initial
begin
button=0;clk=1;counter=0;rst=1;
#1 button=1;rst=0;
#3 button=0;
#2 counter=1;
#3 counter=0;
#4 counter=1;
#8 counter=0;
#2 counter=1;
#10 counter=0;
#57 $finish;
end

always #1 clk=~clk;
endmodule
