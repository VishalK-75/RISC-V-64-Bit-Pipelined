module PC_64(clk,rst,StallF,PC_Next,PC);

    input clk, rst, StallF;
    input [63:0] PC_Next;
    
    output reg [63:0] PC;
    
    always @(posedge clk or posedge rst) begin
        if (rst) 
            PC <= 64'h0000000000000000;
        else if (!StallF) 
            PC <= PC_Next;
    end
endmodule