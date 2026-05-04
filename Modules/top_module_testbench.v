`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2026 05:36:08 PM
// Design Name: 
// Module Name: top_module_testbench
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


module top_module_testbench;
    reg clk1 = 1'b0;
    wire[31:0] incr;
    reg reset1;
    wire empty;
    wire full;
    wire[31:0] tics_8_4mhz;
    wire fifo_dds;
    wire clk_20Mhz;
    wire clk_8_4MHZ;
    wire data_out;
    wire[15:0] sine;
    wire locked;
    wire wr_en;
    wire rd_en;
    wire dds_en;
    wire dds_aresetn;
    
top_module test1(
     .clk(clk1),
     .incr(incr),
     .reset(reset1),
     .empty(empty),
     .full(full),
     .tics_8_4mhz(tics_8_4mhz),
     .fifo_dds(fifo_dds),
     .clk_20Mhz(clk_20Mhz),
     .clk_8_4MHZ(clk_8_4MHZ),
     .data_out(data_out),
     .sine(sine),
     .locked(locked),
     .dds_en(dds_en),
     .dds_aresetn(dds_aresetn),
     .wr_en(wr_en),
     .rd_en(rd_en)
     
   );
    
    
    always #5 clk1 = ~clk1;

    initial begin
    reset1 = 1'b1;
    
    #100
    reset1 = 1'b0;

    end

  
endmodule
