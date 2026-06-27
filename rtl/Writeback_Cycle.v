module Writeback_Cycle(clk,rst,ResultSrcW,PCPlus4W, ReadDataW, ALUResultW,ResultW);
    input clk, rst, ResultSrcW;
    input [63:0] PCPlus4W, ReadDataW, ALUResultW;
    
    output [63:0] ResultW;
    
    Mux_64 result_mux(.a(ALUResultW), 
                   .b(ReadDataW), 
                   .s(ResultSrcW), 
                   .c(ResultW));
endmodule