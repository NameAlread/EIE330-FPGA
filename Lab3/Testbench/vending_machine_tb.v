module vending_machine_tb;

reg clk;
reg reset;
reg coin_05;
reg coin_1;

wire bottle_out;

vending_machine uut (
    .clk(clk), 
    .reset(reset), 
    .coin_05(coin_05), 
    .coin_1(coin_1), 
    .bottle_out(bottle_out)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk; 
end

initial begin
    reset = 1;
    coin_05 = 0;
    coin_1 = 0;

    #100;
    reset = 0;
    
    // 测试用例1：投入足够的硬币购买一瓶饮料
    #20 coin_1 = 1; // 投入1元硬币
    #40 coin_1 = 0;
    #20 coin_05 = 1; // 投入0.5元硬币
    #40 coin_05 = 0;
    
    // 检查是否出货
    #20; // 等待一个时钟周期以检查出货信号
    
    // 测试用例2：投入不足的硬币
    #100 coin_05 = 1; // 投入0.5元硬币
    #40 coin_05 = 0;
    
    // 检查是否没有出货
    #20; // 等待一个时钟周期以检查出货信号
    
    // 测试用例3：投入足够的硬币购买一瓶饮料
    #100 coin_05 = 1; // 再投入0.5元硬币
    #40 coin_05 = 0;
    
    // 检查是否出货
    #20; // 等待一个时钟周期以检查出货信号
    
    // 结束测试
    #100;
    $finish;
end

endmodule
