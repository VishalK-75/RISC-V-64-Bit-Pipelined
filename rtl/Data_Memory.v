module Data_Memory(A,clk,rst,WD,WE,RD);
    input rst,clk,WE;
    input [63:0] A,WD;
    output [63:0]RD;
    
    reg [63:0] Data_Mem [1023:0];
    
    assign RD = (WE == 1'b0) ? Data_Mem[A[63:3]] : 64'h0000000000000000;
    
    always @(posedge clk)
    begin
      if(WE)
        begin
        Data_Mem[A] <= WD;
        end
    end
endmodule
