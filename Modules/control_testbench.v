`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2026 02:09:58 PM
// Design Name: 
// Module Name: control_testbench
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


module control_testbench;
reg clk = 1'b0;
wire[15:0] sine;
wire clk_8_4MHZ;
wire[31:0] incr;
reg reset;
wire  locked;
wire[10:0]tics_clk;
wire dds_en;
wire dds_aresetn;
wire[31:0] tics_8_4mhz;
wire clk_fifo;

dds_control cont1(
 .clk(clk),
 .incr(incr), 
 .reset(reset),
 .clk_8_4MHZ(clk_8_4MHZ),
 .locked(locked),
 .tics_clk(tics_clk),
 .sine(sine),
 .dds_en(dds_en),
 .dds_aresetn(dds_aresetn),
 .tics_8_4mhz(tics_8_4mhz)
    );

always #5 clk = ~clk;
initial begin 
reset = 1'b1;

#100;
reset = 1'b0;

end

endmodule
