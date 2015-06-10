`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:00 05/20/2015 
// Design Name: 
// Module Name:    Proporcional 
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
module Proporcional #(parameter Magnitud=18, Decimal=0, N = Magnitud+Decimal+1)
	(
	input wire clk, reset,
	input wire signed [N-1:0]y,
	output wire signed [N-1:0]proporcional
    );

  wire signed [N-1:0]proporcional_R;
	 
Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
    .A(19'd18), 
    .B(y), 
    .multi(proporcional_R)
    );
	 
Registro_N_bits #(.N(N)) Reg_Timing (
    .clock(clk), 
    .reset(reset), 
    .d(proporcional_R), 
    .q(proporcional)
    );


endmodule
