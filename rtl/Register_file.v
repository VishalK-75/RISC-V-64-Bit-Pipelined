module Register_file_64(A1,A2,A3,WE3,WD3,clk,rst,RD1,RD2);
    input [4:0] A1,A2,A3;
    input [63:0] WD3;
    input clk,rst,WE3;
    output [63:0] RD1,RD2;
    
    reg [63:0] Register [31:0];
    
    always @(posedge clk)
    begin
      if(WE3)
       begin
       Register[A3] <= WD3;
       end
    end      
    
    assign RD1 = (rst) ? 64'h0000000000000000 : ((A1 == 5'b00000) ? 64'h0000000000000000 : Register[A1]);
    assign RD2 = (rst) ? 64'h0000000000000000 : ((A2 == 5'b00000) ? 64'h0000000000000000 : Register[A2]);
     
     initial begin 
        Register[5] = 64'h0000000000000005;
        Register[6] = 64'h0000000000000004;
     end
endmodule
