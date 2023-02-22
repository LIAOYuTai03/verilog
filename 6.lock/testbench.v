`timescale 1ns/1ps         

module lock_sim();    

reg        clk;
reg        rst;
reg        set;
reg        sure;
reg        check;
reg  [3:0] row;
wire [3:0] col;
wire [7:0]       led_en;
wire [6:0]       led;
wire        cnt_end;
wire led0,led1,led2,led3;

reg [7:0] keycase_cnt;   //按键个数计数
wire keycase_inc;

parameter CNT_THRESHOLD=5;

counter #(CNT_THRESHOLD, 24) u_test_counter(     //用于生成时序匹配的row信号
    .clk(clk), 
    .reset(rst), 
    .cnt_inc(1), 
    .cnt_end(cnt_end)
);

lock #(CNT_THRESHOLD) u_lock(   
    .clk(clk), 
    .rst(rst), 
    .set1(set),
    .sure(sure),
    .check(check),
    .row(row), 
    .col(col), 
    .led_en(led_en), 
    .led(led),
    .led0(led0),
    .led1(led1),
    .led2(led2),
    .led3(led3)
);
   
always #5 clk = ~clk;

initial begin
    rst = 1'b1;clk = 0;row = 4'b1111;sure=1'b0;check=1'b0;set=1'b0;
    # 10 rst = 1'b0;set=1'b1;
    #10 set=1'b0;
    #725 sure=1'b1;
    #10 sure=1'b0;check=1'b1;                    //设置密码
    #10 check=1'b0;
    #690 sure=1'b1;
    #10 sure=1'b0;set=1'b1;                    //第一次验证
    #10 set=1'b0;
    #710 sure=1'b1;
    #10 sure=1'b0;check=1'b1;                      //设置密码
    #10 check=1'b0;
    #700 sure=1'b1;
    #10 sure=1'b0;check=1'b1;                     //第一次验证
    #10 check=1'b0;
    #700 sure=1'b1;                         
    #10 sure=1'b0;check=1'b1;                      //第二次验证
    #10 check=1'b0;
    #700 sure=1'b1;
    #10 sure=1'b0;                     //第三次验证
    # 10000
    $finish;
end
    

assign keycase_inc = cnt_end;

always @(posedge clk, posedge rst) begin
    if (rst) keycase_cnt <= 0;
    else if (keycase_inc) keycase_cnt <= keycase_cnt + 1;
end
    
always @(*) begin
    case(keycase_cnt[7:2])  //每轮4次扫描，去掉低2位即第几个测试用例计数
        8'b0000_00:
            if(col==4'b0111) row = 4'b0111;  // 测试右边第一列按键输入
            else row = 4'b1111;
        8'b0000_01: 
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111;
        8'b0000_10:
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111;                                     //设置密码  123
        8'b0000_11: 
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111;      
        8'b0001_00:                           //测试右边第二列按键输入
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111;
        8'b0001_01:
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111;                                     //第一次尝试成功   123
        8'b0001_10: 
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111; 
        8'b0001_11: 
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111; 
        8'b0010_00: 
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111;                                      //设置密码   121
        8'b0010_01: 
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111; 
        8'b0010_10: 
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111; 
        8'b0010_11: 
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111;                                      //第一次尝试错误 231
        8'b0011_00: 
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111; 
        8'b0011_01: 
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111; 
        8'b0011_10: 
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111;                                    // 第二次尝试错误 323
        8'b0011_11: 
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111; 
        8'b0100_00: 
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111; 
        8'b0100_01: 
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111;                                          //第三次尝试错误213
        default:
            row = 4'b1111; 
    endcase
end

endmodule

