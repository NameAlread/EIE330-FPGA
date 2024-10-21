`timescale 1ns / 1ps

module fadder_tb;

    // 输入信号
    reg btn1;  // 第一个加数（addend）
    reg btn2;  // 第二个加数（augend）
    reg btn3;  // 进位输入（carry-in）

    // 输出信号
    wire led0; // 和输出（sum）
    wire led1; // 进位输出（carry-out）


    fadder uut (
        .btn1(btn1), 
        .btn2(btn2), 
        .btn3(btn3), 
        .led0(led0), 
        .led1(led1)
    );

    
    initial begin
        
        btn1 = 0; btn2 = 0; btn3 = 0;
        
        // 等待100纳秒
        #100;
        
        // 应用测试向量
        // 测试向量1: A=0, B=0, Cin=0
        btn1 = 0; btn2 = 0; btn3 = 0;
        #100;
        
        // 测试向量2: A=0, B=0, Cin=1
        btn1 = 0; btn2 = 0; btn3 = 1;
        #100;
        
        // 测试向量3: A=0, B=1, Cin=0
        btn1 = 0; btn2 = 1; btn3 = 0;
        #100;
        
        // 测试向量4: A=0, B=1, Cin=1
        btn1 = 0; btn2 = 1; btn3 = 1;
        #100;
        
        // 测试向量5: A=1, B=0, Cin=0
        btn1 = 1; btn2 = 0; btn3 = 0;
        #100;
        
        // 测试向量6: A=1, B=0, Cin=1
        btn1 = 1; btn2 = 0; btn3 = 1;
        #100;
        
        // 测试向量7: A=1, B=1, Cin=0
        btn1 = 1; btn2 = 1; btn3 = 0;
        #100;
        
        // 测试向量8: A=1, B=1, Cin=1
        btn1 = 1; btn2 = 1; btn3 = 1;
        #100;
        
        
        $finish;
    end
    
    
    always begin
        #10; // 每10纳秒打印一次
        $display("Time = %t, btn1 = %b, btn2 = %b, btn3 = %b, led0 = %b, led1 = %b", 
                 $time, btn1, btn2, btn3, led0, led1);
    end

endmodule
