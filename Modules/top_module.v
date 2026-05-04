`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2026 04:57:18 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    // Только внешние сигналы
    input wire clk,      // тактовый генератор с платы
    input wire reset,    // кнопка сброса
    output wire[15:0] sine,  // выходной сигнал (на ЦАП/пин)
    output wire[15:0] cosine
);

    // ===== Внутренние провода (соединяют блоки) =====
    wire locked;
    wire clk_20Mhz;
    wire clk_8_4MHZ;
    
    wire empty;
    wire full;
    wire fifo_dds;
    
    wire data_out;
    wire wr_en;
    wire rd_en;
    wire dds_en;
    wire dds_aresetn;
    
    wire[31:0] incr;
    wire[33:0] tics_8_4mhz;
    wire[10:0] tics_clk;

    
//   output wire[31:0] incr,
//   output wire empty,
//   output wire full,
//   output wire[31:0] tics_8_4mhz,
//   output wire fifo_dds,
//   output wire clk_20Mhz,
//   output wire clk_8_4MHZ,
//   output wire data_out,
//   output wire wr_en,
//   output wire[15:0] sine,
//   output wire rd_en,
//   output wire locked,
//   output wire dds_en,
//   output wire dds_aresetn
    
    
    


//    reg clk1 = 1'b0;
//    reg reset1 = 1'b1;
//    always #5 clk1 = ~clk1;
//    wire[31:0] incr;
//    reg reset;
//    wire empty;
//    wire full;
//    wire[31:0] tics_8_4mhz;
//    wire fifo_dds;
//    wire clk_20Mhz;
//    wire clk_8_4MHZ;
//    wire data_out;
//    wire[9:0] g1;
//    wire[9:0] g2;
   
    
    


//    initial begin
//    reset1 = 1'b1;
    
//    #100
//    reset1 = 1'b0;

//   end

   fifo_generator_0 fifo_gen (
  .rst(reset),                    // input wire rst
  .wr_clk(clk_20Mhz),              // input wire wr_clk
  .rd_clk(clk_8_4MHZ),              // input wire rd_clk
  .din(data_out),                    // input wire [0 : 0] din
  .dout(fifo_dds),                  // output wire [0 : 0] dout
  .wr_en(wr_en),                // input wire wr_en
  .rd_en(rd_en),                // input wire rd_en
  .full(full),                  // output wire full
  .empty(empty)              // output wire empty
);

dds_control control_dds(
 .clk(clk),
 .incr(incr), 
 .reset(reset),
 .clk_8_4MHZ(clk_8_4MHZ),
 .locked(locked),
 .tics_clk(tics_clk),
 .sine(sine),
 .cosine(cosine),
 .dds_en(dds_en),
 .dds_aresetn(dds_aresetn),
 .tics_8_4mhz(tics_8_4mhz),
 .empty(empty),
 .fifo_dds(fifo_dds),
 .rd_en(rd_en)
 
    );
    
    
  Gold_Code gold1( 
 .clk(clk),
 .data_out(data_out),
 .reset(reset),
 .clk_20Mhz(clk_20Mhz),
 .locked(locked),
 .full(full),
 .wr_en(wr_en),
 .tics_clk(tics_clk)
 
 
 );





 
endmodule
