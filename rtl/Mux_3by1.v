module Mux_3by1(a,b,c,s,d);
    input [63:0] a,b,c;
    input [1:0] s;
    
    output [63:0] d;
    
     assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 
                64'h0000000000000000;
endmodule
