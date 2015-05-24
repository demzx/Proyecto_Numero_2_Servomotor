`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:43 05/20/2015 
// Design Name: 
// Module Name:    I_PD 
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
module I_PD #(parameter Magnitud=17, Decimal=0, N = Magnitud+Decimal+1)
	(
		input wire clk, reset, enable,
		input wire signed [N-1:0]referencia, y,
		output wire signed [N-1:0]IPD
    );

wire signed [N-1:0]error, integrador, proporcional, derivador, Integrador_Proporcional;
	 
CalculoError #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) ERROR (
    .referencia(referencia), 
    .y(y), 
    .error(error)
    );

Integrador #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) INTEGRADOR (
    .clk(clk), 
    .reset(reset), 
    .enable(enable), 
    .error(error),
    .integrador(integrador)
    );
	 
Proporcional #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) PROPORCIONAL (
    .y(y), 
    .proporcional(proporcional)
    );
	 
Derivador #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) DERIVADOR (
    .clk(clk), 
    .reset(reset), 
    .enable(enable), 
    .y(y), 
    .derivador(derivador)
    );

Suma #(.N(N)) Suma_Integrador_Proporcional (
    .A(integrador), 
    .B(-(proporcional)), 
    .SUMA(Integrador_Proporcional)
    );

Suma #(.N(N)) Suma_Integrador_Proporcional_Derivador (
    .A(Integrador_Proporcional), 
    .B(-(derivador)), 
    .SUMA(IPD)
    );

endmodule
