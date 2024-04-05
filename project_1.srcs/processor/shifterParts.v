module sixteenLeftShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[31:16] = A[15:0];
    assign res[15:0] = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
endmodule

module eightLeftShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[31:8] = A[23:0];
    assign res[7:0] = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};

endmodule

module fourLeftShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[31:4] = A[27:0];
    assign res[3:0] = {1'b0,1'b0,1'b0,1'b0};

endmodule

module twoLeftShift(res, A);     
    input [31:0] A;
    output [31:0] res;
    assign res[31:2] = A[29:0];
    assign res[1:0] = {1'b0,1'b0};
endmodule

module oneLeftShift(res, A);     
    input [31:0] A;
    output [31:0] res;
    assign res[31:1] = A[30:0];
    assign res[0] = {1'b0};
endmodule

module sixteenRightShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[15:0] = A[31:16];
    assign res[31:16] = {A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31]};
endmodule

module eightRightShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[23:0] = A[31:8];
    assign res[31:24] = {A[31],A[31],A[31],A[31],A[31],A[31],A[31],A[31]};
endmodule

module fourRightShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[27:0] = A[31:4];
    assign res[31:28] = {A[31],A[31],A[31],A[31]};
endmodule

module twoRightShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[29:0] = A[31:2];
    assign res[31:30] = {A[31],A[31]};
endmodule

module oneRightShift(res, A);      
    input [31:0] A;
    output [31:0] res;
    assign res[30:0] = A[31:1];
    assign res[31] = A[31];
endmodule