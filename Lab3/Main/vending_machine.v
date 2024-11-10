module vending_machine(
    input clk,             // 时钟信号
    input reset,           // 复位信号
    input coin_05,         // 0.5元硬币投入信号
    input coin_1,          // 1元硬币投入信号
    output reg bottle_out  // 饮料出货信号
);

// 定义状态
localparam IDLE = 0, INSERT_COIN = 1, CHECK_BALANCE = 2, DISPENSE = 3;

// 定义内部变量
reg [1:0] state = IDLE;
reg [1:0] balance = 0; // 余额，最大为2元

// 状态转换逻辑
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        balance <= 0;
        bottle_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (coin_05 || coin_1) begin
                    state <= INSERT_COIN;
                end
            end
            INSERT_COIN: begin
                if (coin_05) begin
                    balance <= balance + 1;
                end else if (coin_1) begin
                    balance <= balance + 2;
                end
                state <= CHECK_BALANCE;
            end
            CHECK_BALANCE: begin
                if (balance >= 2) begin
                    state <= DISPENSE;
                end else begin
                    state <= IDLE;
                end
            end
            DISPENSE: begin
                bottle_out <= 1; // 出货一瓶饮料
                #10; // 假设出货需要10个时钟周期
                bottle_out <= 0;
                balance <= 0; // 重置余额
                state <= IDLE;
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule