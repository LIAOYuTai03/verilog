module led_display_ctr(
    input wire rst,button,counter,clk,
    output wire [6:0] led,
    output wire [7:0] led_en
    );

wire[7:0]q;
wire[7:0]p;

timer u_timer(.clk(clk),.rst(rst),.button(button),.q(p));
avoid u_avoid(.counter(counter),.clk(clk),.button(button),.rst(rst),.q(q));
display u_display(.rst(rst),.button(button),.clk(clk),.q(q),.p(p),.A(led_en),.led(led));

endmodule
