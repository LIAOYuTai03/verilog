module reg8file(
	input wire[7:0] d,
	input wire clk,clr,en,
	input wire[2:0] wsel,
	input wire[2:0] rsel,
	output reg[7:0] q
);

wire[7:0] r0;
wire[7:0] r1;
wire[7:0] r2;
wire[7:0] r3;
wire[7:0] r4;
wire[7:0] r5;
wire[7:0] r6;
wire[7:0] r7;
reg[7:0] en1;

dff u_dff_0(.clk(clk),.d(d),.clr(clr),.en(en1[0]),.q(r0));
dff u_dff_1(.clk(clk),.d(d),.clr(clr),.en(en1[1]),.q(r1));
dff u_dff_2(.clk(clk),.d(d),.clr(clr),.en(en1[2]),.q(r2));
dff u_dff_3(.clk(clk),.d(d),.clr(clr),.en(en1[3]),.q(r3));
dff u_dff_4(.clk(clk),.d(d),.clr(clr),.en(en1[4]),.q(r4));
dff u_dff_5(.clk(clk),.d(d),.clr(clr),.en(en1[5]),.q(r5));
dff u_dff_6(.clk(clk),.d(d),.clr(clr),.en(en1[6]),.q(r6));
dff u_dff_7(.clk(clk),.d(d),.clr(clr),.en(en1[7]),.q(r7));

always @(*)
begin
    if(en)
    begin
    en1=8'b00000000;
    en1[wsel]=1;
    end
    else en1=8'b00000000;
end

always @(*)
begin
    case(rsel)
        0:q=r0;
        1:q=r1;
        2:q=r2;
        3:q=r3;
        4:q=r4;
        5:q=r5;
        6:q=r6;
        7:q=r7;
        default:q=0;
    endcase
end

endmodule