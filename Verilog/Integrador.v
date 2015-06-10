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
module Integrador #(parameter Magnitud=18, Decimal=0, N = Magnitud+Decimal+1)
(
	input wire clk, reset, enable,
	input wire signed [N-1:0]error,
	output wire signed [N-1:0] integrador
    );
	 
wire signed [N-1:0] SalidaMultiplicacion,SalidaMultiplicacion_R,SalidaRegistro,error_R;


Registro_N_bits #(.N(N)) Reg_Timing (
    .clock(clk), 
    .reset(reset), 
    .d(error), 
    .q(error_R)
    );


Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
    .A(19'd7), 
    .B(error_R), 
    .multi(SalidaMultiplicacion)
    );
	 
Registro_N_bits #(.N(N)) Reg_Timing2 (
    .clock(clk), 
    .reset(reset), 
    .d(SalidaMultiplicacion), 
    .q(SalidaMultiplicacion_R)
    );
	 
	 
Suma #(.N(N)) sum (
    .A(SalidaRegistro), 
    .B(SalidaMultiplicacion_R), 
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
