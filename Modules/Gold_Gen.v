`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:39 06/29/2014 
// Design Name: 
// Module Name:    Gold_Code 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Gold_Code(
  input clk,
  input reset,
  output wire full,
  output reg data_out=0,
  output reg[1023:0] data_collecter = 0,
  output wire clk_20Mhz,
  wire locked,
  output reg wr_en = 1'b0,
  output reg[10:0] tics_clk = 0,
  output reg[9:0] g1 = 10'b1111111111,
  output reg[9:0] g2 = 10'b1111111111,
  output reg[11:0]tic = 0
);
    always @(posedge clk_20Mhz) begin
    if(reset) begin
    g1[9:0]                 <= 10'b1111111111;
    g2[9:0]                 <= 10'b1111111111;
    data_out                <= 1'b0;
    data_collecter[1023:0]  <= 1024'b0;
    wr_en                   <= 1'b0;
    tics_clk[10:0]          <= 11'b0; 
    tic[11:0]               <= 12'b0;
    g2_in                   <= 1'b0;
    g2_out                  <= 1'b0;
    g1_in                   <= 1'b0;
    g1_out                  <= 1'b0;
    
    end
end
clk_wiz_1 c2
   (
    // Clock out ports
    
    .clk_out2(clk_20Mhz),     // output clk_out2
    .reset(reset),
    // Status and control signals    
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);


	
	 
//reg g1_in;
//reg g2_in;
//reg g1_out;
//reg g2_out;
// БЕРИ ЗНАЧЕНИЯ data_out с 1 по 1023 такты!
reg g2_in = 0;
reg g2_out =0;
reg g1_in = 0;
reg g1_out = 0;

//reg[9:0] g1 = 10'b1111111111;
//reg[9:0] g2 = 10'b1111111111;
parameter width = 1023;


//reg clk1 = 1'b0;
//   parameter period_clk = 5;
//   always begin
//   clk1 = 1'b0;
//   #(period_clk/2) clk1 = ~clk1;
//   #(period_clk/2);
//   end


reg done = 1'b0;

always @(posedge clk_20Mhz) begin
//        if(!full) begin    
	if(locked == 1) begin
	   if (tics_clk < 10) begin
	   tics_clk = tics_clk + 1;
	   end
	   else if (done == 0  & tics_clk == 10) begin
	   wr_en = 1'b1;
	
g1_in =  g1[2] ^ g1[9];
g2_in =  g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1];
g1_out = g1[9];
g2_out = g2[9];

g1 = {g1[8:0], g1_in};
g2 = {g2[8:0], g2_in};

data_out = g1_out ^ g2_out;


 data_collecter[tic] = data_out;
 tic = tic + 1;
		if(tic == 1023) begin
		done <= 1'b1;
		end
	end
	end
	end
	
	





endmodule


