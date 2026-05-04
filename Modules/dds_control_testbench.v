`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 07:48:50 PM
// Design Name: 
// Module Name: dds_control_testbench
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


module dds_control_testbench;
    
    reg clk;
    parameter PERIODCLK = 10;
    wire [31:0] incr;
    wire [15:0] sine;
    wire clk_6MHZ;
    wire [15:0] phase;
    
    
    
    
    always begin
    clk = 1'b0;
    #(PERIODCLK/2) clk = ~clk;
    #(PERIODCLK/2);
    end
    
    
   clk_wiz_0 c2
   (
    // Clock out ports
    .clk_out1(clk_6MHZ),     // output clk_out1
    // Status and control signals
    
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);

    dds_control c1(
   .clk(clk),
   .incr(incr)
    );
    
    
dds_compiler_0 u2 (
  .aclk(clk_6MHZ),                                // input wire aclk    
  .m_axis_data_tdata(sine),                      // output wire [31 : 0] m_axis_data_tdata
  .s_axis_phase_tdata(incr),
  .s_axis_phase_tvalid(1'b1),
       
  .m_axis_phase_tdata(phase)    // output wire [15 : 0] m_axis_phase_tdata
  );




endmodule
