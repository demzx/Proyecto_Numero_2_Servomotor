`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:03 05/20/2015 
// Design Name: 
// Module Name:    tiempodemuestreo 
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
module tiempodemuestreo(
 input wire Clck_in,enable,
 input wire reset_Clock,
 output reg Clock_out
 ); 
 
 
 reg [18:0] contador; 


 
always @(posedge Clck_in,posedge reset_Clock) 
 begin
      if (reset_Clock)
		   begin
		   Clock_out <= 0;
			contador <= 0;
			end 
      else if (enable)
          begin		
		    if (contador == 19'd500000)  
		        begin                    
			     contador <=19'd0;       
		        Clock_out <= ~Clock_out;
		        end 
		     else 
		        contador <= contador + 1'b1; 
          end 
		else 
		   begin 
		   contador <= 0;
			Clock_out <= 0;
			end
 end 
  
endmodule 




  