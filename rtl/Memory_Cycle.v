module Memory_Cycle(clk, rst, MemWriteM, RegWriteM, ResultSrcM, PCPlus4M, ALUResultM, WriteDataM,
       RdM, RegWriteW, ResultSrcW,PCPlus4W, ReadDataW, ALUResultW, RdW);
    input clk, rst, MemWriteM, RegWriteM;
    input [2:0] ResultSrcM;
    input [63:0] PCPlus4M, ALUResultM, WriteDataM;
    input [4:0] RdM;
    
    output RegWriteW, ResultSrcW;
    output [63:0] PCPlus4W, ReadDataW, ALUResultW;
    output [4:0] RdW;
    
    wire [63:0] ReadDataM;
    
    reg RegWriteM_r;
    reg [2:0] ResultSrcM_r;
    reg [63:0] ReadDataM_r, ALUResultM_r, PCPlus4M_r;
    reg [4:0] RdM_r;
        
    Data_Memory Data_mem(.A(ALUResultM), 
                         .clk(clk), 
                         .rst(rst), 
                         .WD(WriteDataM), 
                         .WE(MemWriteM), 
                         .RD(ReadDataM));
    
    always @(posedge clk) begin
        if (rst) begin
            ResultSrcM_r <= 3'b000;   
            RegWriteM_r  <= 1'b0;
            PCPlus4M_r   <= 64'h0;  
            ALUResultM_r <= 64'h0;
            ReadDataM_r  <= 64'h0;  
            RdM_r        <= 5'b0;
        end 
        else begin
            ResultSrcM_r <= ResultSrcM;   
            RegWriteM_r  <= RegWriteM;
            PCPlus4M_r   <= PCPlus4M;    
            ALUResultM_r <= ALUResultM;
            ReadDataM_r  <= ReadDataM;    
            RdM_r        <= RdM;
        end 
    end
    
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r[0];
    assign PCPlus4W = PCPlus4M_r;
    assign ReadDataW = ReadDataM_r;
    assign ALUResultW = ALUResultM_r;
    assign RdW = RdM_r;   
endmodule