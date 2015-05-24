`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:00:57 05/20/2015 
// Design Name: 
// Module Name:    Integrador 
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
module Integrador #(parameter Magnitud=17, Decimal=0, N = Magnitud+Decimal+1)
(
	input wire clk, reset, enable,
	input wire signed [N-1:0]error,
	output wire signed [N-1:0] integrador
    );
	 
wire signed [N-1:0] SalidaMultiplicacion, SalidaRegistro;

Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
    .A(18'd7), 
    .B(error), 
    .multi(SalidaMultiplicacion)
    );

Suma #(.N(N)) sum (
    .A(SalidaRegistro), 
    .B(SalidaMultiplicacion), 
    .SUMA(integrador)
    );

Registro_Pipeline #(.N(N)) Reg (
    .clk(clk), 
    .reset(reset), 
    .data_in(integrador), 
    .enable(enable), 
    .q_out(SalidaRegistro)
    );

endmodule
