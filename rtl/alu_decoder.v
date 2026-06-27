module alu_decoder(op,funct7,ALUOp,funct3,ALUControl);
    input [6:0] op, funct7;
    input [2:0] ALUOp;
    input [2:0] funct3;
    output reg [3:0] ALUControl;
    
    wire [1:0] concat = {op[5], funct7[5]};
    
    always @(*) begin
        case(ALUOp)
            3'b000: ALUControl = 4'b0000; 
            3'b001: ALUControl = 4'b0001; 
            3'b010: begin
                case(funct3)
                    3'b000: ALUControl = (concat == 2'b11) ? 4'b0001 : 4'b0000; 
                    3'b111: ALUControl = 4'b0010; 
                    3'b110: ALUControl = 4'b0011; 
                    3'b010: ALUControl = 4'b0101; 
                    default: ALUControl = 4'b0000;
                endcase
            end
            3'b110: begin
                case(funct3)
                    3'b000: ALUControl = (funct7[5] == 1'b1) ? 4'b0101 : 4'b0100; 
                    default: ALUControl = 4'b0100;
                endcase
            end
            3'b100: begin
                case(funct3)
                    3'b000: ALUControl = 4'b0100; 
                    default: ALUControl = 4'b0100;
                endcase
            end
            
            default: ALUControl = 4'b0000;
        endcase
    end
endmodule