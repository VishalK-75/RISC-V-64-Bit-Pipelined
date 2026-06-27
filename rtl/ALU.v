module ALU(A,B,ALUControl,Result,N,C,Z,V);
     input [63:0] A,B;
     input [3:0] ALUControl;
     output [63:0] Result;
     output Z,N,V,C;
     wire [63:0] a_and_b;
     wire [63:0] a_or_b;
     wire [63:0] not_b;
     wire [63:0] mux_1;
     wire [63:0] sum;
     wire [63:0] mux_2;
     wire cout;
     wire [63:0] slt;
     wire [31:0] sum_32;
     wire [63:0] word_result;
     
     assign a_and_b = A&B;
     assign a_or_b = A|B;
     assign not_b = ~B;
     
     assign mux_1 = (ALUControl[0]==1'b0)? B : not_b;
     
     assign {cout,sum} = A+mux_1+ALUControl[0];
     assign slt = {63'b0,sum[63]};
     
     assign sum_32 = A[31:0] + mux_1[31:0] + ALUControl[0];  
     assign word_result = {{32{sum_32[31]}}, sum_32};
     
     assign mux_2 = (ALUControl[2:0]==3'b000) ? sum : 
                     (ALUControl[2:0]==3'b001) ? sum : 
                     (ALUControl[2:0]==3'b010) ? a_and_b :
                      (ALUControl[2:0]==3'b011) ? a_or_b :
                      (ALUControl[2:0]==3'b101) ? slt : 64'h0000000000000000;
                      
     assign Result = (ALUControl[3] == 1'b1) ? word_result : mux_2;
     
     assign Z = (Result == 64'h0000000000000000);
     assign N = Result[63];
     assign C = cout & (~ALUControl[1]);
     assign V = (~ALUControl[1]) & (sum[63] ^ A[63]) & (~(ALUControl[0] & A[63] & B[63]));
endmodule
