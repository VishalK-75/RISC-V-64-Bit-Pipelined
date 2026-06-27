module Mux_64(a,b,s,c);

    input [63:0] a,b;
    input s;
    
    output [63:0] c;
    
    assign c = (~s) ? a : b;
endmodule
