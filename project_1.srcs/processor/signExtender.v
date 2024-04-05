module signExtender(res, in);
    input [16:0] in;
    output [31:0] res;
    assign res [16:0]  = in;
    assign res[31:17] = {15{in[16]}};

endmodule

module signExtenderJ(res, in);
    input [26:0] in;
    output [31:0] res;
    assign res [26:0]  = in;
    assign res[31:27] = {5{1'b0}};

endmodule