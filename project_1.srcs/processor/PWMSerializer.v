/*

This module takes in a desired duty cycle, specified by the duty_cycle input, and outputs a 
PWM signal with the specified duty cycle

*/

module PWMSerializer #(
    parameter 
    // The following parameters are in MHz
    PULSE_FREQ = 500,         // How often to check if the pulse should end
    SYS_FREQ   = 100000000        // Base FPGA Clock; Nexys A7 uses a 100 Mhz Clock (in HZ)
    )(
    input clk,              // System Clock
    input reset,            // Reset the counter
    input[6:0] duty_cycle,       // Duty Cycle of the Wave, between 0 and 99
    output reg signal = 0   // Output PWM signal
    );
    
    // goal is that we get 500Hz signal, which means 0.002 second cycle
//    reg clockdiv_reg;
//    reg[31:0] count;
//    always @(posedge clk) begin
//        count <= count + 1;
//        if (count == 31'd1000) begin
//            count <= 0;
//            clockdiv_reg <= ~clockdiv_reg;
//        end
//    end
    
    wire [31:0] duty_cycle_normalized;
    assign duty_cycle_normalized = duty_cycle*PULSE_WINDOW/100;
    
    // Define local parameters to be used
    localparam PULSE_WINDOW = SYS_FREQ/PULSE_FREQ;
    localparam PULSE_HALF   = PULSE_WINDOW >> 1;
    localparam PULSE_BITS   = $clog2(PULSE_HALF) + 1;
    
    // Use a counter to determine when the pulse is HIGH
    reg[PULSE_BITS-1:0] pulseCounter = 0;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            pulseCounter <= 0;
        end else begin
            if(pulseCounter < PULSE_WINDOW-1) begin
                pulseCounter <= pulseCounter + 1;
            end else begin
                pulseCounter <= 0;
            end
        end
    end
    
    // The pulse is high when the counter is less than the specified duty_cycle
    wire lessThan; 
    reg delayerBit = 0;
    assign lessThan = (pulseCounter < duty_cycle_normalized);
    
    // Captured the lessThan signal on the negative edge after it has stabilized
    always @(negedge clk) begin
        signal <= lessThan;
    end
endmodule