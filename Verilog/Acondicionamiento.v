`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:53 06/05/2015 
// Design Name: 
// Module Name:    Acondicionamiento 
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
module Acondicionamiento #(parameter Magnitud=17, Decimal=0, N = Magnitud+Decimal+1, ADC = 12)
	(
		input wire clk, reset, enable,
		input wire signed [N-1:0]referencia, y,
		output wire signed [7:0]Entrada_PWM,
		output wire [9:0]sal_W,
		//output wire [3:0] sal2,
		output wire signed [N-1:0]IPD

    );

wire signed [N-1:0] SalidaMultiplicacion,IPD_R;
wire signed [ADC-1:0] Sal;



I_PD #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) Sal_IPD (
    .clk(clk), 
    .reset(reset), 
    .enable(enable), 
    .referencia(referencia), 
    .y(y), 
    .IPD(IPD)
    );
	 
Registro_N_bits #(.N(N))Reg_Timing (
    .clock(clk), 
    .reset(reset), 
    .d(IPD), 
    .q(IPD_R)
    );



//Multiplicacion #(.Magnitud(Magnitud),.Decimal(Decimal)) mult (
//    .A(18'd2), 
//    .B(IPD_R), 
//    .multi(SalidaMultiplicacion)
//    );



Suma #(.N(ADC)) Suma_Offset (
    .A(IPD_R), 
    .B(19'b0100000000000000000), 
    .SUMA(Sal)
    );
	 
//assign sal = Sal [N-13:0];
//assign sal2 = Sal [ADC-9:0];
assign Entrada_PWM = Sal[ADC-2:ADC-9];
assign sal_W = Sal[9:0];
endmodule
