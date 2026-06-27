module PC_Adder_64(a,b,c);

    input [63:0] a,b;
    output [63:0] c;
    
    assign c = a + b;
endmodule
