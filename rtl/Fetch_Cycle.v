module Fetch_Cycle( clk, rst, PCSrcE, StallF, StallD, PCTargetE, InstrD, PCPlus4D, PCD);    
    input clk, rst, PCSrcE, StallF, StallD;
    input [63:0] PCTargetE;
    
    output [63:0] PCPlus4D,PCD;    
    output [31:0] InstrD;
    
    wire [63:0] PC_F, PCF, PCPlus4F;
    wire [31:0] InstrF;
    
    reg [31:0] InstrF_reg;
    reg [63:0] PCF_reg, PCPlus4F_reg;

    Mux_64 PC_Mux(.a(PCPlus4F), 
               .b(PCTargetE), 
               .s(PCSrcE), 
               .c(PC_F));   
    PC_64 PC_Module(.clk(clk),
                    .rst(rst),
                    .StallF(StallF),
                    .PC_Next(PC_F),
                    .PC(PCF));
    Instr_memory Instr_mem(.rst(rst), 
                           .A(PCF), 
                           .RD(InstrF));
    PC_Adder_64 PC_Add(.a(PCF), 
                    .b(64'd4), 
                    .c(PCPlus4F));  
      
    always @(posedge clk) begin
        if (rst) begin
            InstrF_reg   <= 32'h00000000;
            PCF_reg      <= 64'h0000000000000000;
            PCPlus4F_reg <= 64'h0000000000000000;
        end  
        else if (!StallD) begin
            InstrF_reg   <= InstrF;
            PCF_reg      <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end        
       
    assign InstrD = (rst) ? 32'h00000000 : InstrF_reg;
    assign PCD = (rst) ? 64'h0000000000000000 : PCF_reg;
    assign PCPlus4D = (rst) ? 64'h0000000000000000 : PCPlus4F_reg;
endmodule