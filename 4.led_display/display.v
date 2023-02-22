module display(
    input wire rst, button, clk,
    input wire[7:0] q,
    input wire[7:0] p,
    output reg[7:0] A,
    output reg[6:0]led
    );

reg [17:0]cnt;
wire cnt_end = (cnt == 18'd200000);                                 //¸Ä200000/4
reg flag;

always @(posedge clk or posedge rst)
begin
if(rst) flag =1'b0;
else if(button) flag =1'b1;
end

always @(posedge clk or posedge rst)
begin
if(rst) cnt<=18'b0;
else if(button)cnt <= 18'b0;
else if(cnt_end) cnt <= 18'b0;
else if(flag) cnt<=cnt+18'b1;
else cnt<=0;
end

always @(posedge clk or posedge rst)
begin
if(rst)A <= 8'b11111110;
else if(button)A <= 8'b11111110;
else if(cnt_end)A <= {A[6:0], A[7]};
end

always @(*)
begin
case(A)
8'b11111110:led=7'b1001100;
8'b11111101:led=7'b0000001;
8'b11111011:led=7'b0100100;
8'b11110111:led = 7'b0000001;
8'b11101111:case(rst)
            0:case(q[3:0])
            4'd1:led=7'b1001111;
            4'd2:led=7'b0010010;
            4'd3:led=7'b0000110;
            4'd4:led=7'b1001100;
            4'd5:led=7'b0100100;
            4'd6:led=7'b0100000;
            4'd7:led=7'b0001111;
            4'd8:led=7'b0000000;
            4'd9:led=7'b0001100;
            4'd0:led=7'b0000001;
            4'd10:led=7'b0001000;
            4'd11:led=7'b1100000;
            4'd12:led=7'b1110010;
            4'd13:led=7'b1000010;
            4'd14:led=7'b0110000;
            4'd15:led=7'b0111000;
            endcase
            1:led=7'b0000001;
            endcase
8'b11011111:case(rst)
            0:case(q[7:4])
            4'd1:led=7'b1001111;
            4'd2:led=7'b0010010;
            4'd3:led=7'b0000110;
            4'd4:led=7'b1001100;
            4'd5:led=7'b0100100;
            4'd6:led=7'b0100000;
            4'd7:led=7'b0001111;
            4'd8:led=7'b0000000;
            4'd9:led=7'b0001100;
            4'd0:led=7'b0000001;
            4'd10:led=7'b0001000;
            4'd11:led=7'b1100000;
            4'd12:led=7'b1110010;
            4'd13:led=7'b1000010;
            4'd14:led=7'b0110000;
            4'd15:led=7'b0111000;
            endcase
            1:led = 7'b0000001;
            endcase
8'b10111111:case(rst)
            0:case(p[3:0])
            4'd1:led=7'b1001111;
            4'd2:led=7'b0010010;
            4'd3:led=7'b0000110;
            4'd4:led=7'b1001100;
            4'd5:led=7'b0100100;
            4'd6:led=7'b0100000;
            4'd7:led=7'b0001111;
            4'd8:led=7'b0000000;
            4'd9:led=7'b0001100;
            4'd0:led=7'b0000001;
            4'd10:led=7'b0001000;
            4'd11:led=7'b1100000;
            4'd12:led=7'b1110010;
            4'd13:led=7'b1000010;
            4'd14:led=7'b0110000;
            4'd15:led=7'b0111000;
            endcase
            1:led = 7'b0000001;
            endcase
8'b01111111:case(rst)
            0:case(p[7:4])
            4'd2:led=7'b0010010;
            4'd1:led=7'b1001111;
            4'd0:led=7'b0000001;
            endcase
            1:led = 7'b0000001;
            endcase
endcase
end

endmodule
