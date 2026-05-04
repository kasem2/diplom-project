`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 06:39:01 PM
// Design Name: 
// Module Name: dds_control
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


module dds_control(
 input wire clk,
 output reg[31:0] incr = 31'd0,
 output wire empty,
 input wire fifo_dds,
 input wire reset,
 output reg[29:16] poff = 1'b0,
 output reg rd_en = 1'b0,
 output wire clk_8_4MHZ,
 output reg[10:0] tics_clk = 0,
 output wire locked,
 output reg[15:0] sine,
 output reg[15:0] cosine,
 output reg dds_en = 1'b0,
 output reg dds_aresetn,
 output reg[33:0] tics_8_4mhz = 0
 
    );
   
    reg[15:0] incr_accum = 0;
    reg[15:0] delta = 1 ;   
    reg up_flag = 1;
    reg down_flag = 0;
    wire[15:0] phase;
    wire[31:0] signal;
   
    always@(posedge clk_8_4MHZ) begin
        if(reset) begin
            incr                <= 31'b0;
            incr_accum[15:0]    <= 16'b0;          
            rd_en               <= 1'b0;
            poff[29:16]         <= 13'b0;
            tics_clk[10:0]      <= 11'b0;
            dds_aresetn         <= 1'b0;
            dds_en              <= 1'b0;
            tics_8_4mhz[33:0]   <= 34'b0;
            up_flag             <= 1'b1;
            down_flag           <= 1'b0;
            
            
            
        end
    end       
            
  
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            dds_aresetn = 1'b0;
        end else begin
            dds_aresetn = locked;  // Сброс снимается когда locked=1
        end
    end
   
    
   
 
   
   
//   always begin
//   clk1 = 1'b0;
//   #(period_clk/2) clk1 = ~clk1;
//   #(period_clk/2);
//   end
   

clk_wiz_1 c1
   (
    // Clock out ports
    .clk_out1(clk_8_4MHZ),     // output clk_out1
    // Status and control signals
     .reset(reset),
     .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);
   
    
    
    always @(posedge clk_8_4MHZ) begin
     if(!reset) begin
        if(locked == 1 & (tics_clk == 9 | tics_clk == 10)) begin
        tics_8_4mhz <= tics_8_4mhz + 1;
        if ((tics_8_4mhz + 9) % (7000) == 0) begin
        rd_en <= 1'b1;
        end
     
        else begin
        rd_en <= 1'b0;
        end
        end
     end
    end
    
    
    always @(posedge clk_8_4MHZ) begin
        if(!reset) begin
            if(locked == 1 & (tics_clk == 9 | tics_clk == 10) & rd_en == 1) begin
                if(!empty) begin
                     if (fifo_dds == 1) begin
                    poff = 2**12;
                    end
                    else begin
                    poff = 0;
                    end
                 end
           end
            if(locked == 1 & (tics_clk == 9 | tics_clk == 10)) begin
         incr[29:16] = poff;
            end
       end
   end
    
//    always @(posedge clk_8_4MHZ) begin
//    if(locked == 1 & (tics_clk == 9 | tics_clk == 10)) begin
//     incr[29:16] = poff;
//    end
//    end
    
    //POFF = s_axis_phase_tdata[26:16] 
// always @(posedge clk_8_4MHZ) begin
// clk_read_fifo = 1'b0;
// tics_8_4mhz = tics_8_4mhz + 1;
// //6993
//    if (tics_8_4mhz % (14000 - 7) == 0 ) begin        
//        clk_read_fifo <= 1'b1;
//        incr[29:16] = 2**12;
//    end
//end
 
 
dds_compiler_1 d1 (
  .aclken(dds_en),                            // input wire aclken
  .aresetn(dds_aresetn),                          // input wire aresetn
  .aclk(clk_8_4MHZ),                                // input wire aclk    
  .m_axis_data_tdata(signal),                      // output wire [31 : 0] m_axis_data_tdata
  .s_axis_phase_tdata(incr),
  .s_axis_phase_tvalid(1'b1),
       
  .m_axis_phase_tdata(phase)    // output wire [15 : 0] m_axis_phase_tdata
  );






always @(posedge clk_8_4MHZ) begin
    if(locked == 1 & tics_clk < 10) begin
    tics_clk <= tics_clk + 1;
    end
    if(locked == 1 & (tics_clk == 10)) begin
if  (incr_accum[15:0] == 7000) begin
    up_flag = 0;
    down_flag = 1;
    end
else if (incr_accum[15:0] == 0) begin 
    up_flag = 1;
    down_flag = 0;
    end
    end
end

always @(posedge clk_8_4MHZ) begin
    if(locked == 1 & (tics_clk == 9)) begin
        dds_en = 1;
        sine[15:0] = signal[15:0];
        cosine[15:0] = signal[31:16];
        end
       end


always @(posedge clk_8_4MHZ) begin 
            if(locked == 1 & tics_clk < 10) begin
    tics_clk <= tics_clk + 1;
    end
    if(locked == 1 & (tics_clk == 10)) begin
    
    if (up_flag == 1 & down_flag == 0) begin
incr_accum[15:0] = incr_accum[15:0] + delta;
 incr[15:0] = incr_accum >> 2;

    end
     if (up_flag == 0 & down_flag == 1) begin
incr_accum[15:0] = incr_accum[15:0] - delta;
 incr[15:0] = incr_accum >> 2;

    end
            end
end



endmodule

//module dds_testbench;
//reg clk_6mhz;
//reg clk;
//wire[31:0] incr;
//parameter period_clk = 10;
//always begin 
//clk = 1'b0;
//#(period_clk/2) clk = ~clk;
//#(period_clk/2);
//end

//clk_wiz_0 c2
//   (
//    // Clock out ports
//    .clk_out1(clk_6MHZ),     // output clk_out1
//    // Status and control signals
    
//   // Clock in ports
//    .clk_in1(clk)      // input clk_in1
//);

    
    
//dds_compiler_0 u2 (
//  .aclk(clk_6MHZ),                                // input wire aclk    
//  .m_axis_data_tdata(sine),                      // output wire [31 : 0] m_axis_data_tdata
//  .s_axis_phase_tdata(incr),
//  .s_axis_phase_tvalid(1'b1),
       
//  .m_axis_phase_tdata(phase)    // output wire [15 : 0] m_axis_phase_tdata
//  );

//dds_control d1(
//.clk(clk),
//.incr(incr)
//);
//endmodule

