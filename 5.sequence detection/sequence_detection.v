module sequence_detection(
    input wire clk,rst,button,
    input wire[7:0] switch,
    output reg led
    );

parameter IDLE = 3'b000;
parameter s0 = 3'b001;
parameter s1 = 3'b010;
parameter s2 = 3'b011;
parameter s3 = 3'b100;
parameter s4 = 3'b101;
parameter s5 = 3'b110;

reg[2:0] current_state;
reg[2:0] next_state;

reg endl;

reg cnt;
wire cnt_end=(cnt==1'd0);               
reg[3:0] number;

reg flag;

reg out;

always @(posedge clk or posedge rst)
begin
if(rst) flag<=1'b0;
else if(button) flag<=1'b1;
else flag<=1'b0;
end

always @(posedge clk or posedge rst)
begin
if(rst) endl<=1'b0;
else if(button) endl<=1'b0;
else if(number==4'd8) endl<=1'b1;
end

always @(posedge clk or posedge rst)
begin
if(rst) cnt<=1'b0;
else if(cnt_end) cnt<=1'b0;
else cnt<=cnt+1'b1;
end

always @(posedge clk or posedge rst)
begin
if(rst) number<=4'b0;
else if(button) number<=4'b0;
else if(number==4'd8) number <= 4'd0;
else if(cnt_end) number<=number+4'b1;
else number<=number;
end

always @(posedge clk or posedge rst)
begin
if(rst) current_state<=IDLE;
else if(button) current_state<=s0;
else current_state<=next_state;
end

always @(*)
begin
case(current_state)
    IDLE:if(flag&switch[number]) next_state=s0;
            else if(flag) next_state=s1;
            else next_state=IDLE;
    s0:if(endl) next_state=IDLE;
            else if(!switch[number]) next_state=s1;
            else next_state=s0;
    s1:if(endl) next_state=IDLE;
            else if(switch[number]) next_state=s2;
            else next_state=s0;
    s2:if(endl) next_state=IDLE;
            else if(switch[number]) next_state=s0;
            else next_state=s3;
    s3:if(endl) next_state=IDLE;
            else if(switch[number]) next_state=s4;
            else next_state=s1;
    s4:if(endl) next_state=IDLE;
            else if(switch[number]) next_state=s5;
            else next_state=s0;
    s5:next_state=s5;
endcase
end

always @(posedge clk or posedge rst)
begin
if(rst) led<=1'b0;
else if(current_state==s5) led<=1'b1;
else led<=1'b0;
end

endmodule
