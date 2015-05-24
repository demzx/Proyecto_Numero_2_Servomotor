`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:29 05/20/2015 
// Design Name: 
// Module Name:    PWM 
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
module PWM  #(N=8) // se pone como parametro el tamano de bits de la entrada 

(  
  input wire Clock,reset, // se declaran el clock y el reset 
  input wire [N-1:0] Entrada, // se declara la entrada del modulo 
  output wire pwm_out // se declara la salida del PWM
    ); 
	 // se utuliza la siguinete formula hasta cuanto va a llegar el contador 
	 // frecucnia de salida 10 KHz
	 // T = Clock nexys * periodo de mi senal PWM 
	 // T = 100MHz * 0.1ms = 10000
	 // despues calculamos cuanto dure la senal para que cambie de paso con la siguinete formula 
	 //SR = T/ 2^N = 
	 
localparam  SR = 40;

reg pwm; // se declara un reg que tome el valor de la salida del pwm 
reg [13:0] contador ; // se declara un contador para poder obetenr la frecuencia que se necesite 


always @(posedge Clock,posedge reset)
begin 
     if(reset) // se ponen las senales en 0 
	     begin
	     pwm <=0;
	     contador <= 0;
	     end 
	  else
        begin	  
	     contador <= contador +1'b1; // el contador aumneta 
		  
        if (contador <= SR*Entrada) 
	         pwm <= 1'b1;
        else 	  
	         pwm <= 1'b0;
			
	      if (contador >= 10000)
	          contador <= 0;
         end			
      end 

assign pwm_out = pwm;

endmodule
