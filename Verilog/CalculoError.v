`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:52 05/20/2015 
// Design Name: 
// Module Name:    CalculoError 
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
module CalculoError #(parameter Magnitud=17, Decimal=0, N = Magnitud+Decimal+1)
	(
		input wire signed [N-1:0]referencia, y,
		output wire signed [N-1:0]error
    );
	 
Suma #(.N(N)) sum (
    .A(referencia), 
    .B(-(y)), 
    .SUMA(error)
    );


endmodule
