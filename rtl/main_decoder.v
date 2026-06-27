module main_decoder(Op,RegWrite, MemWrite, ResultSrc, ALUSrc, Branch,ImmSrc,ALUOp);
    input [6:0] Op;
    output RegWrite, MemWrite, ResultSrc, ALUSrc, Branch;
    output [1:0] ImmSrc;
    output [2:0] ALUOp;
 
    assign RegWrite = ((Op == 7'b0000011) | (Op == 7'b0110011) | (Op == 7'b0010011) | 
                       (Op == 7'b0111011) | (Op == 7'b0011011)) ? 1'b1 : 1'b0;
                       
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;
    
    assign ALUSrc   = ((Op == 7'b0000011) | (Op == 7'b0100011) | (Op == 7'b0010011) | 
                       (Op == 7'b0011011)) ? 1'b1 : 1'b0;
                       
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;
    
    assign ImmSrc   = (Op == 7'b0100011) ? 2'b01 : 
                      (Op == 7'b1100011) ? 2'b10 : 2'b00;
                      
    assign Branch   = (Op == 7'b1100011) ? 1'b1 : 1'b0;
     
    assign ALUOp    = (Op == 7'b0110011) ? 3'b010 : 
                      (Op == 7'b0111011) ? 3'b110 : 
                      (Op == 7'b0011011) ? 3'b100 : 
                      (Op == 7'b1100011) ? 3'b001 : 3'b000; 
endmodule