module runlight (
    input clk,           // 50MHz系统时钟
    input rst_n,         // 复位信号，低电平有效
    output reg [3:0] led // LED输出信号
);

    reg [24:0] counter;  // 计数器，用于生成0.5秒延时
    reg [1:0] state;     // 当前状态寄存器

    // 定义0.5秒的延时计数值：50M * 0.5 - 1 = 24,999,999
    localparam DELAY = 25_000_000;

    // 时钟和状态转换逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin  // 复位时
            counter <= 0;
            state <= 0;
            led <= 4'b1111;  // 所有LED熄灭
        end else begin
            if (counter < DELAY - 1) begin
                counter <= counter + 1;  // 计数器递增
            end else begin
                counter <= 0;  // 计数器归零
                state <= (state + 1) % 4;  // 状态循环变化

                // 每次将一个LED置为0（点亮），其余为1（熄灭）
                led <= ~(4'b0001 << state);
            end
        end
    end

endmodule
