`timescale 1ns / 1ps

module flowing_water_lights_sim();

reg rst,button,clk;
reg[1:0] freq_set;
wire[7:0] led;

flowing_water_lights u_flowing_water_lights(.rst(rst),.button(button),.clk(clk),.freq_set(freq_set),.led(led));

initial
begin
    clk=1'b0;rst=1'b1;button=1'b0;freq_set=2'b00;
    #5 rst=1'b0;button=1'b1;
    #20 rst=1'b1;
    #4 rst=1'b0;freq_set=2'b01;
    #18 rst=1'b1;
    #2 rst=1'b0;freq_set=2'b10;
    #16 rst=1'b1;
    #4 rst=1'b0;freq_set=2'b11;
    #20 $finish;
end

always #1 clk=~clk;
endmodule
