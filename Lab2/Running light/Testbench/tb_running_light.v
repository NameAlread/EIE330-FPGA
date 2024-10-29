`timescale 1ns / 1ps

module tb_running_light;

    // 定义测试信号
    reg clk;            // 时钟信号
    reg rst_n;          // 复位信号
    wire [3:0] led;     // LED输出

    // 实例化被测试模块
    runlight uut (
        .clk(clk),
        .rst_n(rst_n),
        .led(led)
    );

    // 时钟生成：50MHz -> 周期20ns
    always #10 clk = ~clk;

    // 初始化与仿真逻辑
    initial begin
        // 初始化信号
        clk = 0;
        rst_n = 0;  // 保持复位状态
        #100 rst_n = 1;  // 100ns后释放复位

        // 等待2秒观察LED状态变化
        #200000000;
        $stop;  // 停止仿真
    end

    // 打印每次LED状态变化
    always @(posedge clk) begin
        if (uut.counter == 0)  // 在计数器归零时打印LED状态
            $display("Time: %0dns, LED State: %b", $time, led);
    end

endmodule