module Instr_memory(rst,A,RD);
    input rst;
    input [63:0] A;
    output [31:0] RD;
    
    reg [31:0] Mem [1023:0];
    
    assign RD = (rst == 1'b1) ? 32'h00000000 : Mem[A[63:2]];  
    
  initial begin
   $readmemh("memoryfile.txt", Mem);
  end
endmodule
