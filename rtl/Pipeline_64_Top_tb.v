module Pipeline_64_Top_tb();
    
    reg clk=0,rst;
    
    Pipeline_64_Top uut(.clk(clk), .rst(rst));
    
    always begin
        clk=~clk;
        #50;
    end
    
    initial begin
        rst <= 1'b1;
        #100;
        rst <= 1'b0;
        #2000;
        $finish;
    end
    
    initial begin
       $dumpfile("dump.vcd");
       $dumpvars(0);
    end
endmodule
