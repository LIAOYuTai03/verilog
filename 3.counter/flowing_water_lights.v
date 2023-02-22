module flowing_water_lights(
    input wire rst,button,clk,
    input wire[1:0] freq_set,
    output reg[7:0] led
    );

reg [26:0]cnt;
reg cnt_inc;
reg cnt_end;

always @(*)
begin
    case (freq_set)
        2'b00:cnt_end=cnt_inc &(cnt == 27'd10000000);
        2'b01:cnt_end=cnt_inc &(cnt == 27'd20000000);
        2'b10:cnt_end=cnt_inc &(cnt == 27'd50000000);
        2'b11:cnt_end=cnt_inc &(cnt == 27'd100000000);
        default:cnt_end=0;
    endcase
end

always @(posedge clk or posedge rst)
begin
    if(rst) cnt_inc<=1'b0;
    else if(button) cnt_inc<=1'b1;
end

always @(posedge clk or posedge rst)
begin
    if(rst) cnt<=27'b0;
    else if(cnt_end) cnt<=27'b1;
    else if(cnt_inc) cnt<=cnt+27'b1;
end

always @(posedge clk or posedge rst)
begin 
    if(rst) led<=8'b00000001;
    else if(cnt_end) led<={led[6:0],led[7]};
end
endmodule
