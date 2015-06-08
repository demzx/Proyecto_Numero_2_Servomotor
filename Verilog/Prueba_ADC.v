`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:31 04/03/2015 
// Design Name: 
// Module Name:    Prueba_ADC 
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
module Prueba_ADC(
input wire Clock_Nexys,Reset,reset_Clck,
input wire  data_ADC,start,
output wire done,CS,Clock_Muestreo,
output wire [3:0] data_basura,
output wire [11:0] Dato

 );

wire Clock_out;
assign Clock_Muestreo = Clock_out;

Divisor_Clock_ADC divisor (
    .Clck_in(Clock_Nexys), 
    .reset_Clock(reset_Clck), 
    .Clock_out(Clock_out)
    );

Protocolo_ADC obtener_dato (
    .Clock_Muestreo(Clock_Muestreo), 
    .reset(Reset), 
    .data_ADC(data_ADC), 
    .start(start), 
    .FS(FS), 
    .done(done), 
    .CS(CS), 
    .Enable_divisor(Enable_divisor), 
    .data_basura(data_basura), 
    .Dato(Dato)
    );



tiempodemuestreo muestreo (
    .Clck_in(Clock_Nexys), 
    .enable(Enable_divisor), 
    .reset_Clock(reset_Clck), 
    .Clock_out(FS)
    );







endmodule
