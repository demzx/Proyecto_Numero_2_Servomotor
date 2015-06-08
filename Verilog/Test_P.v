`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:26:25 06/07/2015
// Design Name:   Servo_Top
// Module Name:   C:/Users/Administrador/Documents/UNIVERSIDAD OSCAR/ITCR/11 Semestre/Lab de Digitales/Proyecto4/Respaldo3/Prueba Proyecto/Proyecto_diseno_2/Test_P.v
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

module Test_P;

	// Inputs
	reg Clock_Nexys;
	reg Reset;
	reg reset_Clck;
	reg data_ADC;
	reg start;
	reg [11:0] Entrada_referencia;

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

integer I_PD, k;
reg [11:0]mem1[90:0];
reg [11:0]mem2[90:0];//Se genera una memoria para abir el fichero .txt, donde la primera prametrzacion(los primeros parentesis cuadrados leyendo de izquierda a derecha) son para determinar el tamaño de los bits en el arreglo, mientras que los segundos es para decirmel cuantos datos ahi en el fichero .txt 
reg [11:0]VariableAux;
initial forever
	# 20 Clock_Nexys = ~Clock_Nexys;

initial begin
	// Initialize Inputs
	Clock_Nexys = 0;
	Reset = 0;
	reset_Clck = 0;
	data_ADC = 0;
	start = 0;

	// Wait 100 ns for global reset to finish
	#100;
	  
	// Add stimulus here
	
	// Initialize Inputs
	Clock_Nexys = 0;
	Reset = 1;
	reset_Clck = 1;
	data_ADC = 0;
	start = 0;

	// Wait 100 ns for global reset to finish
	#100;
	  
	// Add stimulus here
	
	// Initialize Inputs
	Reset = 0;
	reset_Clck = 0;
	data_ADC = 0;
	start = 0;

	// Wait 100 ns for global reset to finish
	#100;
	I_PD = $fopen("Salida_I_PD.txt");
	$readmemb("Referencia_Binario.txt",mem1);// carga en mem el los datos del fichero .txt
	$readmemb("y_Binario.txt",mem2);
	for (k=0; k<89; k=k+1)// ciclo for para recorrer el fichero cargado
	begin
	// 
		Entrada_referencia = mem1[k];
		VariableAux = mem2[k];
		@(negedge Clock_Muestreo)
		start = 1;
		repeat(4) @(posedge Clock_Muestreo); // espero 4 ciclos de reloj para mandar los datos de 0 del adc 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[11]; // bit numero 1 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[10]; // bit numero 2 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[9]; // bit numero 3 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[8]; // bit numero 4 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[7]; // bit numero 5 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[6]; // bit numero 6 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[5]; // bit numero 7 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[4]; // bit numero 8 del dato
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[3]; // bit numero 9 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[2]; // bit numero 10 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[1]; // bit numero 11 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = VariableAux[0]; // bit numero 12 del dato
		start = 0; 
      repeat(18) @(posedge Clock_Muestreo);
  // se manda por segunda vez el dato 
		$fdisplayb(I_PD, IPD);
		//#100;
	end
	$fclose(I_PD);//cierra el fichero Documento
	$stop;
	end
      
endmodule

