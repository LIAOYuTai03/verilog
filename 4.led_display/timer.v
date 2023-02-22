module timer(
    input wire clk,rst,button,
    output reg[7:0] q
    );
    
reg [24:0]cnt;
wire cnt_end =(cnt==25'd20000000);                  //¸Ä0/20000000
reg flag;

always @(posedge clk or posedge rst)
begin
if(rst) flag =1'b0;
else if(button) flag =1'b1;
end

always @(posedge clk or posedge rst)begin
if (rst) cnt<=25'd0;
else if (cnt_end|button) cnt<=25'd0;
else if(flag)cnt<=cnt+25'd1;
else cnt<=cnt;
end

always @(posedge clk or posedge rst)
begin
if(rst) q<=8'b0;
else if(button) q<=8'b0;
else if(cnt_end & (q<8'd32)) q<=q+8'b1;
else if(cnt_end & (q==8'd32))q<=0;
end

endmodule
