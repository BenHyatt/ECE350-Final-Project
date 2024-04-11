`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2024 02:46:13 PM
// Design Name: 
// Module Name: servo_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module servo_ctrl(
    input clk,              // System Clock
    input reset,            // Reset the counter
    input [6:0] duty_cycle,
//    output[6:0] duty_cycle,       // Duty Cycle of the Wave, between 0 and 99
//    output reg signal = 0,
//    output wire [1:1] JA_out,
    output wire [1:1] JB_out
    );
    
    assign JB_out[1] = signal;
    
    
    wire signal;
//    assign JA[1] = signal;

//    wire reset;
//    assign reset = BTNR;
    
//    wire clk;
//    assign clk = clk;
    
    PWMSerializer serializer(
    .clk(clk),              // System Clock
    .reset(reset),            // Reset the counter
    .duty_cycle(duty_cycle),       // Duty Cycle of the Wave, between 0 and 99
    .signal(signal)   // Output PWM signal
    );
    
endmodule
