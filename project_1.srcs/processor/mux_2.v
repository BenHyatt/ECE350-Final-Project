module mux_2(out, select, in0, in1);
    input select;
    input [31:0] in0, in1;
    output [31:0] out;
    assign out = select ? in1 : in0;
endmodule
//module mux_2_1(out, select, in0, in1);
//    input select;
//    input  in0, in1;
//    output out;
//    assign out = select ? in1 : in0;
//endmodule