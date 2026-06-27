module Pipeline_64_Top(input clk, input rst);
    
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, BranchE, 
         MemWriteM, RegWriteM, ResultSrcW;
    wire [2:0] ResultSrcE, ResultSrcM;
    wire [4:0] RdW, RdE, RdM, RS1_E, RS2_E, RS1_D, RS2_D;
    wire [63:0] PCTargetE, PCPlus4D, PCD, ResultW, RD1E, RD2E, Imm_ExtE, PCE,
                PCPlus4E, PCPlus4M, ALUResultM, WriteDataM, PCPlus4W, ReadDataW, ALUResultW; 
    wire [31:0] InstrD;
    wire [3:0] ALUControlE;
    wire [1:0] ForwardAE, ForwardBE;       
    wire StallF, StallD, FlushE;

    Fetch_Cycle Fetch(
        .clk(clk), .rst(rst), 
        .PCSrcE(PCSrcE), .StallF(StallF), .StallD(StallD),
        .PCTargetE(PCTargetE), 
        .InstrD(InstrD), .PCPlus4D(PCPlus4D), .PCD(PCD));

    Decode_Cycle Decode(
        .clk(clk), .rst(rst), 
        .FlushE(FlushE), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW), .RdW(RdW), .ResultW(ResultW),
        .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE),
        .RD1E(RD1E), .RD2E(RD2E), .Imm_ExtE(Imm_ExtE), .PCE(PCE), .PCPlus4E(PCPlus4E),
        .RdE(RdE), .RS1_E(RS1_E), .RS2_E(RS2_E), .RS1_D(RS1_D), .RS2_D(RS2_D));

    Execute_Cycle Execute(
        .clk(clk), .rst(rst),
        .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE),
        .RD1E(RD1E), .RD2E(RD2E), .Imm_ExtE(Imm_ExtE), .PCE(PCE), .PCPlus4E(PCPlus4E), .RdE(RdE),
        .PCSrcE(PCSrcE), .MemWriteM(MemWriteM), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM),
        .PCTargetE(PCTargetE), .PCPlus4M(PCPlus4M), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .RdM(RdM),
        .ResultW(ResultW), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE));

    Memory_Cycle Memory(
        .clk(clk), .rst(rst),
        .PCPlus4M(PCPlus4M), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM),
        .MemWriteM(MemWriteM), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .RdM(RdM),
        .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .PCPlus4W(PCPlus4W), 
        .ReadDataW(ReadDataW), .ALUResultW(ALUResultW), .RdW(RdW));

    Writeback_Cycle Writeback(
        .clk(clk), .rst(rst),
        .ResultSrcW(ResultSrcW), .PCPlus4W(PCPlus4W), .ReadDataW(ReadDataW), 
        .ALUResultW(ALUResultW), .ResultW(ResultW));   

    Hazard_Unit Hazard_Unit(
        .rst(rst),
        .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .ResultSrcE(ResultSrcE),
        .Rs1D(RS1_D), .Rs2D(RS2_D), .Rs1E(RS1_E), .Rs2E(RS2_E),
        .RdE(RdE), .RdM(RdM), .RdW(RdW),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
        .StallF(StallF), .StallD(StallD), .FlushE(FlushE));            
endmodule