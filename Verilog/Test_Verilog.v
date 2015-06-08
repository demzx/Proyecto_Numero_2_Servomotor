`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:36:29 06/07/2015
// Design Name:   Servo_Top
// Module Name:   C:/Users/Administrador/Documents/UNIVERSIDAD OSCAR/ITCR/11 Semestre/Lab de Digitales/Proyecto4/Respaldo3/Proyecto_diseno_2/Test_Verilog.v
// Project Name:  Proyecto_diseno_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Servo_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Verilog;

	// Inputs
	reg Clock_Nexys;
	reg Reset;
	reg reset_Clck;
	reg data_ADC;
	reg start;
	reg [7:0] Entrada_referencia;

	// Outputs
	wire CS;
	wire Clock_Muestreo;
	wire [3:0] data_basura;
	wire pwm_out;
	wire [17:0] IPD;

	// Instantiate the Unit Under Test (UUT)
	Servo_Top uut (
		.Clock_Nexys(Clock_Nexys), 
		.Reset(Reset), 
		.reset_Clck(reset_Clck), 
		.data_ADC(data_ADC), 
		.start(start), 
		.Entrada_referencia(Entrada_referencia), 
		.CS(CS), 
		.Clock_Muestreo(Clock_Muestreo), 
		.data_basura(data_basura), 
		.pwm_out(pwm_out), 
		.IPD(IPD)
	);

	initial begin
		// Initialize Inputs
		Clock_Nexys = 0;
		Reset = 0;
		reset_Clck = 0;
		data_ADC = 0;
		start = 0;
		Entrada_referencia = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

