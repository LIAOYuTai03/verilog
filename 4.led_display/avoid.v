module avoid(
    input wire counter,clk,button,rst,
    output reg[7:0] q 
    );

reg sig_r0, sig_r1;
reg [30:0]cnt;
reg flag,flag1;

always @(posedge clk or posedge rst)
begin
if(rst) flag =1'b0;
else if(button) flag =1'b1;
end

always @(posedge clk or posedge rst)
begin
if(rst) sig_r0 <= 1'b0;
else sig_r0 <= counter;
end

always @(posedge clk or posedge rst)
begin
if(rst) sig_r1<=1'b0;
else sig_r1 <= sig_r0;
end

wire pos_edge = sig_r0 & ~sig_r1;
wire neg_edge = ~sig_r0 & sig_r1;

always @(*)
begin
if(pos_edge) flag1=1'b1;
else if(neg_edge) flag1=1'b0;
end

always @(posedge clk or  posedge rst)
begin
if(rst) cnt<=31'd0;
else if(button) cnt<=31'd0;
else if(flag1 & flag)cnt<=cnt+31'd1;
else cnt<=0;
end

always @(posedge clk or posedge rst)
begin 
if(rst) q<=8'b0;
else if(button) q<=8'b0;
else if((cnt>=31'd1500000)&(~flag1)) q<=q+8'b1;             //¸Ä3/1500000
else q<=q;
end

endmodule
