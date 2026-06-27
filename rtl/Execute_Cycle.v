module Execute_Cycle(clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,ALUControlE,
       RD1E, RD2E, Imm_ExtE, PCE, PCPlus4E,RdE,ResultW,ForwardAE, ForwardBE,PCTargetE, PCPlus4M, 
       ALUResultM, WriteDataM,PCSrcE,MemWriteM, RegWriteM, ResultSrcM,RdM);
       
    input clk, rst, RegWriteE, ALUSrcE, MemWriteE, BranchE;
    input [2:0] ResultSrcE;
    input [3:0] ALUControlE;
    input [63:0] RD1E, RD2E, Imm_ExtE, PCE, PCPlus4E;
    input [4:0] RdE;
    input [63:0] ResultW;
    input [1:0] ForwardAE, ForwardBE;
    
    output [63:0] PCTargetE, PCPlus4M, ALUResultM, WriteDataM;
    output PCSrcE, MemWriteM, RegWriteM;
    output [2:0] ResultSrcM;
    output [4:0] RdM;
    
    wire [63:0] SrcAE, SrcBE, SrcBE_inter, ResultE;
    wire ZeroE;
    
    reg [63:0] PCPlus4E_r, ALUResultE_r, RD2E_r;
    reg [4:0] RdE_r;
    reg MemWriteE_r, RegWriteE_r;
    reg [2:0] ResultSrcE_r;
    
    Mux_64 alu_mux(.a(SrcBE_inter), 
                .b(Imm_ExtE), 
                .s(ALUSrcE), 
                .c(SrcBE));
    
    Mux_3by1 AE_mux(.a(RD1E), 
                    .b(ResultW), 
                    .c(ALUResultM), 
                    .s(ForwardAE), 
                    .d(SrcAE));
                    
    Mux_3by1 BE_mux(.a(RD2E), 
                    .b(ResultW), 
                    .c(ALUResultM), 
                    .s(ForwardBE), 
                    .d(SrcBE_inter));
    
    ALU ALU_Unit(.A(SrcAE), 
                 .B(SrcBE), 
                 .ALUControl(ALUControlE), 
                 .Result(ResultE), 
                 .Z(ZeroE));
    PC_Adder_64 pc_imm_adder(.a(PCE), 
                          .b(Imm_ExtE), 
                          .c(PCTargetE));
    
    always @(posedge clk) begin
        if (rst) begin
            MemWriteE_r  <= 1'b0;  
            ResultSrcE_r <= 3'b000;  
            RegWriteE_r  <= 1'b0;
            PCPlus4E_r   <= 64'h0; 
            ALUResultE_r <= 64'h0; 
            RD2E_r       <= 64'h0;
            RdE_r        <= 5'b0;
        end 
        else begin
            MemWriteE_r  <= MemWriteE;   
            ResultSrcE_r <= ResultSrcE;   
            RegWriteE_r  <= RegWriteE;
            PCPlus4E_r   <= PCPlus4E;    
            ALUResultE_r <= ResultE;      
            RD2E_r       <= SrcBE_inter;
            RdE_r        <= RdE;
        end 
    end
    
    assign PCSrcE = (rst) ? 1'b0 : (ZeroE & BranchE);
    assign MemWriteM = MemWriteE_r;
    assign RegWriteM = RegWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign PCPlus4M = PCPlus4E_r;
    assign ALUResultM = ALUResultE_r;
    assign WriteDataM = RD2E_r;
    assign RdM = RdE_r;
endmodule