`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:13 06/06/2015 
// Design Name: 
// Module Name:    Servo_Top 
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
module Servo_Top #( parameter ADC_A=8,Ref_A=8,Magnitud=18, Decimal=0, N = Magnitud+Decimal+1)

(input wire Clock_Nexys,Reset,
 input wire data_ADC,start,
 input wire signed [7:0] Entrada_referencia,
 output wire CS,Clock_Muestreo,
 output wire [3:0] data_basura,ADC_W,
 output wire [9:0]sal_W,
 output wire pwm_out,
 // pruebas 
 output wire signed [N-1:0]IPD
 );

wire signed [N-1:0] yk,Referencia; // Entradas del IPD 
wire signed [ADC_A-1:0] Adc_out,Adc_OFF, refe_OFF; // salidas de los resultados de las operciones intermedias
wire signed [Ref_A-1:0] Entrada_PWM; // entrada de referencia y del pwm 
wire signed [11:0] adc;

Prueba_ADC ADC (
    .Clock_Nexys(Clock_Nexys), 
    .Reset(Reset), 
    .reset_Clck(Reset), 
    .data_ADC(data_ADC), 
    .start(start), 
    .done(done), 
    .CS(CS), 
    .Clock_Muestreo(Clock_Muestreo), 
    .data_basura(data_basura), 
    .Dato(adc)
    );

assign Adc_out = adc[11:4];
assign ADC_W = adc[3:0];
Suma #(.N(N)) offset_adc ( // suma que se hace con los datos del adc para poder quitar el offset
    .A({11'd0, Adc_out}), 
    .B(-(19'd128)), 
	 //Se cambio por YK
    .SUMA(yk)
    );
//	assign yk = Adc_OFF;
//assign yk = {Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF[7],Adc_OFF};
//assign yk = {Adc_OFF[11],Adc_OFF[11],Adc_OFF[11],Adc_OFF[11],Adc_OFF[11],Adc_OFF[11],Adc_OFF[11],Adc_OFF}; // se hace una extension de signo del dato que viene del adc para  
                                                                   // poder meter el dato en el modulo del IPD
																						 
//assign yk = {Adc_out[11],Adc_out[11],Adc_out[11],Adc_out[11],Adc_out[11],Adc_out[11],Adc_out};
	          
//**** mae oscar hice la extension de signo asi  pero no estoy seguro si ahce se tenia que hacer o si hay una forma mas facil                                                    // poder incluirla en el ipd ya que aqui es de 18 bits

Suma #(.N(N)) ofset_referencia ( // se le quita el ofset a la parte de referencia del servo 
    .A({11'd0, Entrada_referencia}),                      
    .B(-(19'd128)), 
	 // Se cambio por REFERENCIA
    .SUMA(Referencia)
    );
// assign Referencia = refe_OFF;
//assign Referencia = {refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF[7],refe_OFF};
//assign Referencia = {refe_OFF[11],refe_OFF[11],refe_OFF[11],refe_OFF[11],refe_OFF[11],refe_OFF[11],refe_OFF[11],refe_OFF}; // se hace una extension de signo de la referencia para poder incluirla en el ipd 
//assign Referencia = {Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia[11],Entrada_referencia}; 
//**** mae oscar hice la extension de signo asi  pero no estoy seguro si ahce se tenia que hacer o si hay una forma mas facil

Acondicionamiento #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N), .ADC(19)) tratamiento_IPD (
    .clk(Clock_Nexys), 
    .reset(Reset), 
    .enable(done), 
    .referencia(Referencia), 
    .y(yk),
	 .sal_W(sal_W),
    .IPD(IPD), 	 
    .Entrada_PWM(Entrada_PWM)
    );
	 
PWM #(.N(Ref_A)) pwm (
    .Clock(Clock_Nexys), 
    .reset(Reset), 
    .Entrada(Entrada_PWM), 
    .pwm_out(pwm_out)
    );

endmodule
