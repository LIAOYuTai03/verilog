module lock #(
    parameter CNT_THRESHOLD=1000000-1
)(
    input wire clk,set1,rst,sure,check,
    input  wire [3:0] row,
    output wire  [3:0] col,
    output wire[7:0] led_en,
    output wire[6:0] led,
    output wire led0,led1,led2,led3
    );
    
wire[3:0] keyboard_num;
wire keyboard_en;

keyboard #(CNT_THRESHOLD
)u_keyboard(
.clk(clk),.reset(rst),.row(row),.col(col),.keyboard_num(keyboard_num),.keyboard_en(keyboard_en)
);

state_machine u_state_machine(
.clk(clk),.rst(rst),.sure(sure),.check(check),.set(set1),.keyboard_num(keyboard_num),.keyboard_en(keyboard_en),.led_en(led_en),.led(led),.led0(led0),.led1(led1),.led2(led2),.led3(led3)
);
endmodule
