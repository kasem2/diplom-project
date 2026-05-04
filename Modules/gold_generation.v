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
    output reg data_out = 0,
    output reg g2_in = 0,
    output reg g2_out = 0,
    output reg g1_in = 0,
    output reg g1_out = 0,
    output reg [11:0] tic = 0,
    output reg [1022:0] data_collecter = 0
);
    
reg clk1;
parameter period_clk = 100;

always begin
    clk1 = 1'b0;
    #(period_clk/2) clk1 = ~clk1;
    #(period_clk/2);
end

reg [9:0] g1 = 10'b1111111111;
reg [9:0] g2 = 10'b1111111111;
parameter width = 1023;

reg done = 1'b0;



always @(posedge clk1) begin
    if (!done) begin
        // G1: сдвиг вправо (стандарт IS-GPS)
        g1_in <= g1[9] ^ g1[2];
        g1_out <= g1[0];  // ← Выход теперь младший бит!
        g1 <= {g1_in, g1[9:1]};
        
        // G2: сдвиг вправо (стандарт IS-GPS)
        g2_in <= g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1];
        g2_out <= g2[0];  // ← Выход теперь младший бит!
        g2 <= {g2_in, g2[9:1]};
        
        data_out <= g1_out ^ g2_out;
        data_collecter[tic] <= data_out;
        tic <= tic + 1;
        
        if (tic == 1022) begin
            done <= 1'b1;
        end
    end
end


