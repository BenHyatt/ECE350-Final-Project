// module isRorI(res, A);
//    input [31:0] A;
//    output res;
    
//    assign res = (~A[31] & ~A[30] & ~A[29] & ~A[27]) | (~A[31] & ~A[30] & A[28] & ~A[27]) | (~A[31] & ~A[30] & A[29] & A[27]);

// endmodule


module writesToRD(res, A);
    input [31:0] A;
    output res;
    assign res = (A[31:27]==5'b0) | (A[31:27]==5'b00101) | (A[31:27]==5'b01000);
 endmodule

 module readsRS(res, A);
    input [31:0] A;
    output res;
    assign res = (A[31:27]==5'b0) | (A[31:27]==5'b00101)| (A[31:27]==5'b00111) | (A[31:27]==5'b01000) | (A[31:27]==5'b00010) | (A[31:27]==5'b00110);
 endmodule

 module readsRT(res, A);
    input [31:0] A;
    output res;
    assign res = (A[31:27]==5'b0);
 endmodule

  module readsRDasB(res, A);
    input [31:0] A;
    output res;
    assign res = (A[31:27]==5'b00010) | (A[31:27]==5'b00110) | (A[31:27]==5'b00100); 
 endmodule
 

 