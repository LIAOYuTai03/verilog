module state_machine(
    input wire clk,set,rst,sure,check,
    input wire[3:0] keyboard_num,
    input wire keyboard_en,
    output reg[7:0] led_en,
    output reg[6:0] led,
    output reg led0,led1,led2,led3
    );
    
parameter IDLE =4'b0000;
parameter s0 =4'b0001;
parameter s1 =4'b0010;
parameter s2 =4'b0011;
parameter s3 =4'b0100;
parameter s4 =4'b0101;
parameter s5 =4'b0110;
parameter s6 =4'b0111;
parameter s7 =4'b1000;
parameter s8 =4'b1001;
parameter IDLE1 =3'b000;
parameter a0 =3'b001;
parameter a1 =3'b010;
parameter a2 =3'b011;
parameter a3 =3'b100;
parameter a4 =3'b101;
wire cnt_end;
reg[3:0] current_state;
reg[3:0] next_state;
reg[2:0] current_state1;
reg[2:0] next_state1;
reg[5:0] mi;
reg[5:0] temp;
reg[1:0] n;

always @(posedge clk or posedge rst)                  //¼ÆÊı
begin
if(rst) n<=2'b10;
else if(sure)n<=2'b10;
else if(((current_state==s2)|(current_state==s6)|(current_state==s4)|(current_state==s0))&keyboard_en) n<=n-2'b01;
end 

always @(posedge clk or posedge rst)
begin
if(rst) temp<=6'd0;
else if((current_state==s2)|(current_state==s6)|(current_state==s4))
     begin
     if((n==2'b10)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:temp[5:4]<=2'b01;
     4'd2:temp[5:4]<=2'b10;
     4'd3:temp[5:4]<=2'b11;
     default:temp[5:4]<=2'b00;
     endcase
     end
     else if((n==2'b01)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:temp[3:2]<=2'b01;
     4'd2:temp[3:2]<=2'b10;
     4'd3:temp[3:2]<=2'b11;
     default:temp[3:2]<=2'b00;
     endcase
     end
     else if((n==2'b00)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:temp[1:0]<=2'b01;
     4'd2:temp[1:0]<=2'b10;
     4'd3:temp[1:0]<=2'b11;
     default:temp[1:0]<=2'b00;
     endcase
     end
     end
else if(!((current_state==s2)|(current_state==s6)|(current_state==s4))) temp<=6'd0;
end

always @(*)
begin
    if(rst) next_state1=IDLE1;
    else
    begin
    case(current_state1)
    IDLE1:if(check) next_state1=a0;
            else next_state1=IDLE1;
    a0:if((temp[5:4]==mi[5:4])&&(temp[5:4]!=2'b00)) next_state1=a1;
        else if((temp[5:4]!=mi[5:4])&&(temp[5:4]!=2'b00)) next_state1=a4;
        else next_state1=a0;
    a1:if((temp[3:2]==mi[3:2])&&(temp[3:2]!=2'b00)) next_state1=a2;
        else if((temp[3:2]!=mi[3:2])&&(temp[3:2]!=2'b00))next_state1=a4;
        else next_state1=a1;
    a2:if((temp[1:0]==mi[1:0])&&(temp[1:0]!=2'b00)) next_state1=a3;
        else if((temp[1:0]!=mi[1:0])&&(temp[1:0]!=2'b00))next_state1=a4;
        else next_state1=a2;
    a3:if(sure)next_state1=IDLE1;
        else next_state1=a3;
    a4:if(sure)next_state1=IDLE1;
        else next_state1=a4;
    default:next_state1=IDLE1;
    endcase
    end
end

always @(posedge clk or posedge rst)
begin
if(rst) mi<=6'd0;
else if(current_state==s0)
     begin
     if((n==2'b10)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:mi[5:4]<=2'b01;
     4'd2:mi[5:4]<=2'b10;
     4'd3:mi[5:4]<=2'b11;
     default:mi[5:4]<=2'b00;
     endcase
     end
     else if((n==2'b01)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:mi[3:2]<=2'b01;
     4'd2:mi[3:2]<=2'b10;
     4'd3:mi[3:2]<=2'b11;
     default:mi[3:2]<=2'b00;
     endcase
     end
     else if((n==2'b00)&keyboard_en)
     begin
     case(keyboard_num)
     4'd1:mi[1:0]<=2'b01;
     4'd2:mi[1:0]<=2'b10;
     4'd3:mi[1:0]<=2'b11;
     default:mi[1:0]<=2'b00;
     endcase
     end
     end
else if(current_state==IDLE)mi<=6'd0;
end

counter #(200000-1, 18) u_counter(                                  //200000/1
    .clk(clk), 
    .reset(rst), 
    .cnt_inc(1),
    .cnt_end(cnt_end)
);

always @(posedge clk or posedge rst)
begin
if(rst) current_state<=IDLE;
else current_state<=next_state;
end

always @(posedge clk or posedge rst)
begin
if(rst) current_state1<=IDLE1;
else current_state1<=next_state1;
end

always @(*)
begin
case(current_state)
    IDLE:if(set) next_state=s0;
         else next_state=IDLE;
    s0:if(sure) next_state=s1;
        else next_state=s0;
    s1:if(check)next_state=s2;
        else next_state=s1;
    s2:if(sure&(current_state1==a3)) next_state=IDLE;
        else if(sure) next_state=s3;
        else next_state=s2;
    s3:if(check)next_state=s4;
        else next_state=s3;
    s4:if(sure&(current_state1==a3)) next_state=IDLE;
        else if(sure) next_state=s5;
        else next_state=s4;
    s5:if(check)next_state=s6;
        else next_state=s5;
    s6:if(sure&(current_state1==a3)) next_state=IDLE;
        else if(sure) next_state=s7;
        else next_state=s6;
    default:next_state=s7;
endcase
end

always @(posedge clk or posedge rst)
begin
if(rst) led_en <= 8'b11111110;
else if(cnt_end) led_en<={led_en[6:0],led_en[7]};
end

always@(*)
begin
case(current_state)
    IDLE:led=7'b0000001;
    s0:case(led_en)
        8'b11011111:case(mi[1:0])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
        8'b10111111:case(mi[3:2])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
        8'b01111111:case(mi[5:4])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
        default:led=7'b1111111;
        endcase
    s1:led=7'b1111111;
    s5:led=7'b1111111;
    s3:led=7'b1111111;
    s7:led=7'b0111000;
    default:case(led_en)
            8'b11011111:case(temp[1:0])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
            8'b10111111:case(temp[3:2])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
            8'b01111111:case(temp[5:4])
                    2'b01:led=7'b1001111;
                    2'b10:led=7'b0010010;
                    2'b11:led=7'b0000110;
                    default:led=7'b1111111;
                    endcase
            default:led=7'b1111111;
            endcase
endcase
end

always@(posedge clk or posedge rst)
begin
if(rst) led0<=1'b0;
else if(current_state==s1) led0<=1'b1;
else if(current_state==IDLE) led0<=1'b0;
else led0<=led0;
end

always@(posedge clk or posedge rst)
begin
if(rst) led1<=1'b0;
else if(current_state==s3) led1<=1'b1;
else if(current_state==IDLE) led1<=1'b0;
else led1<=led1;
end

always@(posedge clk or posedge rst)
begin
if(rst) led2<=1'b0;
else if(current_state==s5) led2<=1'b1;
else if(current_state==IDLE) led2<=1'b0;
else led2<=led2;
end

always@(posedge clk or posedge rst)
begin
if(rst) led3<=1'b0;
else if(current_state==s7) led3<=1'b1;
else if(current_state==IDLE) led3<=1'b0;
else led3<=led3;
end

endmodule