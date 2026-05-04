`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 10:32:57 PM
// Design Name: 
// Module Name: Gold_testbench
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


module Gold_testbench;
reg clk = 1'b0;
wire data_out;
wire[1023:0] data_collecter;
wire clk_20Mhz;
  reg reset;                           
  wire wr_en;
  wire rd_en;
  //.dout(dout),                  // output wire [0 : 0] dout
  wire full;                  // output wire full 
  wire dout;
  wire empty;
  wire locked;
  wire[10:0] tics_clk;
  wire[9:0] g1;
  wire[9:0] g2;
  wire [11:0] tic;


   parameter period_clk = 10;
//   always begin    
//   clk = 1'b0;
//   #(period_clk/2) clk = ~clk;
//   #(period_clk/2);
//    end  
always #5 clk = ~clk;
   
 
// clk_wiz_1 c2
//   (
//    // Clock out ports
    
//    .clk_out2(clk_20Mhz),     // output clk_out2
//    // Status and control signals    
//    .locked(locked),       // output locked
//    .reset(reset), // input reset
//   // Clock in ports
//    .clk_in1(clk)      // input clk_in1
//);
 
// fifo_generator_0 genabukin (
//  .rst(reset),                    // input wire rst
//  .wr_clk(clk_20Mhz),              // input wire wr_clk
//  .rd_clk(clk_20Mhz),              // input wire rd_clk
//  .din(data_out),                    // input wire [0 : 0] din
//  .dout(dout),                  // output wire [0 : 0] dout
//  .wr_en(wr_en),                // input wire wr_en
//  .rd_en(rd_en),                // input wire rd_en
//  //.dout(dout),                  // output wire [0 : 0] dout
//  .full(full),                  // output wire full
//  .empty(empty)              // output wire empty
//); 
 
 initial begin
 reset = 1'b1;
// rd_en = 1'b0;
// wr_en = 1'b0;
 
 #100;
 reset = 1'b0;
 
 
 end
// always @(posedge clk_20Mhz) begin
//if (tics_clk == 10) begin 
// wr_en = 1'b1;
// end
// end
 
// always @(posedge clk_20Mhz) begin
//    rd_en = !empty;  // читаем если не пусто
//end
 
 
 
 
 
 
 
 Gold_Code gold1(
 
 .clk(clk),
 .data_collecter(data_collecter),
 .data_out(data_out),
 .reset(reset),
 .clk_20Mhz(clk_20Mhz),
 .locked(locked),
 .full(full),
 .wr_en(wr_en),
 .tics_clk(tics_clk),
 .g1(g1),
 .g2(g2),
 .tic(tic)
 
 
 );

     
    
    
    
    
    
    
    
endmodule
