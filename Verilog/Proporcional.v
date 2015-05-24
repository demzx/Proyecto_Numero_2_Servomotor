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
module Proporcional #(parameter Magnitud=17, Decimal=0, N = Magnitud+Decimal+1)
	(
	input wire signed [N-1:0]y,
	output wire signed [N-1:0]proporcional
    );
	 
Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
    .A(18'd18), 
    .B(y), 
    .multi(proporcional)
    );

endmodule
