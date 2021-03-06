`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:48:04 05/20/2015 
// Design Name: 
// Module Name:    Derivador 
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
module Derivador #(parameter Magnitud=18, Decimal=0, N = Magnitud+Decimal+1)
	(
	input wire clk, reset, enable,
	input wire signed [N-1:0]y,
	output wire signed [N-1:0] derivador
    );
	 
wire signed [N-1:0] SalidaSuma,SalidaSuma_R,derivador_R,SalidaRegistro;

Registro_Pipeline #(.N(N)) Reg (
    .clk(clk), 
    .reset(reset), 
    .data_in(y), 
    .enable(enable), 
    .q_out(SalidaRegistro)
    );

Suma #(.N(N)) sum (
    .A(y), 
    .B(-(SalidaRegistro)), 
    .SUMA(SalidaSuma)
    );
	 
Registro_N_bits #(.N(N)) Reg_Timing (
    .clock(clk), 
    .reset(reset), 
    .d(SalidaSuma), 
    .q(SalidaSuma_R)
    );

Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
    .A(SalidaSuma_R), 
    .B(19'd150), 
    .multi(derivador_R)
    );
	 
Registro_N_bits #(.N(N)) Reg_Timing2 (
    .clock(clk), 
    .reset(reset), 
    .d(derivador_R), 
    .q(derivador)
    );



endmodule

