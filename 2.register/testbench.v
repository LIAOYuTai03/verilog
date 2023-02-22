`timescale 1ns/1ps

module reg8file_sim();

reg[7:0] d;
reg clk, clr, en;
reg[2:0] wsel;
reg[2:0] rsel;
wire[7:0] q;

reg8file u_reg8file(.d(d),.clk(clk),.clr(clr),.en(en),.wsel(wsel),.rsel(rsel),.q(q));

initial
begin
   clk=1'b0;clr=1'b1;en=1'b0;d=8'b00000000;wsel=3'b000;rsel=3'b000;
   #10 en=1'b1;clr=1'b0;d=8'b00000001;
   #10 d=8'b00000010;wsel=3'b001;rsel=3'b001;
   #10 d=8'b00000100;wsel=3'b010;rsel=3'b010;
   #10 d=8'b00001000;wsel=3'b011;rsel=3'b011;
   #10 d=8'b00010000;wsel=3'b100;rsel=3'b100;
   #10 d=8'b00100000;wsel=3'b101;rsel=3'b101;
   #10 d=8'b01000000;wsel=3'b110;rsel=3'b110;
   #10 d=8'b10000000;wsel=3'b111;rsel=3'b111;
   #10 clr=1'b1;en=1'b0;rsel=3'b000;
   #10 rsel=3'b001;
   #10 rsel=3'b010;
   #10 rsel=3'b011;
   #10 rsel=3'b100;
   #10 rsel=3'b101;
   #10 rsel=3'b110;
   #10 rsel=3'b111;
   #10 $finish;
end

always #5 clk = ~clk;

endmodule
