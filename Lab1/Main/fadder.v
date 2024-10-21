module fadder(
    input wire btn1,  // 第一个加数（addend）
    input wire btn2,  // 第二个加数（augend）
    input wire btn3,  // 进位输入（carry-in）
    output wire led0, // 和输出（sum）
    output wire led1  // 进位输出（carry-out）
);

    // 内部信号定义
    wire sum;
    wire carry;

    // 实例化全加器
    full_adder fa(
        .A(btn1),
        .B(btn2),
        .Cin(btn3),
        .Sum(sum),
        .Cout(carry)
    );

    // 将全加器的输出连接到LED
    assign led0 = sum;
    assign led1 = carry;

endmodule

// 全加器模块
module full_adder(
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

    // 使用异或门计算和与进位
    xor(Sum, A, B);
    xor(Cout_int, A, B);
    xor(Cout, Cout_int, Cin);

endmodule