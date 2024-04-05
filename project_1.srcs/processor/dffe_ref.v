module dffe_ref (q, d, clk, en, clr);

   //Inputs
   input d, clk, en, clr;
   
   //Internal wire
   wire clr;

   //Output
   output q;
   
   //Register
   reg q;

   //Intialize q to 0
   initial
   begin
       q = 1'b0;
   end

   //Set value of q on positive edge of the clock or clear
   always @(posedge clk or posedge clr) begin
       //If clear is high, set q to 0
       if (clr) begin
           q <= 1'b0;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule

module register_module(q, d, clk, en, clr);
    input [31:0] d;
    output [31:0] q;
    input clk, en, clr;

    dffe_ref dffe_ref_0(q[0], d[0], clk, en, clr);
    dffe_ref dffe_ref_1(q[1], d[1], clk, en, clr);
    dffe_ref dffe_ref_2(q[2], d[2], clk, en, clr);
    dffe_ref dffe_ref_3(q[3], d[3], clk, en, clr);
    dffe_ref dffe_ref_4(q[4], d[4], clk, en, clr);
    dffe_ref dffe_ref_5(q[5], d[5], clk, en, clr);
    dffe_ref dffe_ref_6(q[6], d[6], clk, en, clr);
    dffe_ref dffe_ref_7(q[7], d[7], clk, en, clr);
    dffe_ref dffe_ref_8(q[8], d[8], clk, en, clr);
    dffe_ref dffe_ref_9(q[9], d[9], clk, en, clr);
    dffe_ref dffe_ref_10(q[10], d[10], clk, en, clr);
    dffe_ref dffe_ref_11(q[11], d[11], clk, en, clr);
    dffe_ref dffe_ref_12(q[12], d[12], clk, en, clr);
    dffe_ref dffe_ref_13(q[13], d[13], clk, en, clr);
    dffe_ref dffe_ref_14(q[14], d[14], clk, en, clr);
    dffe_ref dffe_ref_15(q[15], d[15], clk, en, clr);
    dffe_ref dffe_ref_16(q[16], d[16], clk, en, clr);
    dffe_ref dffe_ref_17(q[17], d[17], clk, en, clr);
    dffe_ref dffe_ref_18(q[18], d[18], clk, en, clr);
    dffe_ref dffe_ref_19(q[19], d[19], clk, en, clr);
    dffe_ref dffe_ref_20(q[20], d[20], clk, en, clr);
    dffe_ref dffe_ref_21(q[21], d[21], clk, en, clr);
    dffe_ref dffe_ref_22(q[22], d[22], clk, en, clr);
    dffe_ref dffe_ref_23(q[23], d[23], clk, en, clr);
    dffe_ref dffe_ref_24(q[24], d[24], clk, en, clr);
    dffe_ref dffe_ref_25(q[25], d[25], clk, en, clr);
    dffe_ref dffe_ref_26(q[26], d[26], clk, en, clr);
    dffe_ref dffe_ref_27(q[27], d[27], clk, en, clr);
    dffe_ref dffe_ref_28(q[28], d[28], clk, en, clr);
    dffe_ref dffe_ref_29(q[29], d[29], clk, en, clr);
    dffe_ref dffe_ref_30(q[30], d[30], clk, en, clr);
    dffe_ref dffe_ref_31(q[31], d[31], clk, en, clr);

endmodule


module register_moduleZero(q, d, clk, en, clr);
    input [31:0] d;
    output [31:0] q;
    input clk, en, clr;

    assign q = 32'b0;

endmodule