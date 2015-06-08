`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:40:30 05/20/2015
// Design Name:   I_PD
// Module Name:   C:/Users/ohskr_000/Documents/Universidad/Lab de Digitales/Cuarto Proyecto/Verilog/I_PD/Test_I_PD.v
// Project Name:  I_PD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: I_PD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_I_PD;

	// Inputs
	reg clk;
	reg reset;
	reg enable;
	reg [17:0] referencia;
	reg [17:0] y;

	// Outputs
	wire [17:0] IPD;

	// Instantiate the Unit Under Test (UUT)
	I_PD uut (
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.referencia(referencia), 
		.y(y), 
		.IPD(IPD)
	);
	
integer I_PD, k;
reg [17:0]mem1[5000:0];
reg [17:0]mem2[5000:0];//Se genera una memoria para abir el fichero .txt, donde la primera prametrzacion(los primeros parentesis cuadrados leyendo de izquierda a derecha) son para determinar el tamaño de los bits en el arreglo, mientras que los segundos es para decirmel cuantos datos ahi en el fichero .txt 

initial forever
	# 20 clk = ~clk;

initial begin
	// Initialize Inputs
	clk = 0;
	reset = 0;
	enable = 0;
	referencia = 0;
	y = 0;

	// Wait 100 ns for global reset to finish
	#100;
	  
	// Add stimulus here
	
	// Initialize Inputs
	clk = 0;
	reset = 1;
	enable = 0;
	referencia = 0;
	y = 0;

	// Wait 100 ns for global reset to finish
	#100;
	  
	// Add stimulus here
	
	// Initialize Inputs
	//clk = 0;
	reset = 0;
	enable = 0;
	referencia = 0;
	y = 0;

	// Wait 100 ns for global reset to finish
	#100;
	I_PD = $fopen("Salida_I_PD.txt");
	$readmemb("Referencia_Binario.txt",mem1);// carga en mem el los datos del fichero .txt
	$readmemb("y_Binario.txt",mem2);
	for (k=0; k<5000; k=k+1)// ciclo for para recorrer el fichero cargado
	begin
//		referencia = mem1[k];
//		y = mem2[k];
		@(posedge clk)
		referencia = mem1[k];
		y = mem2[k];
		enable = 1;
		@(posedge clk)
		enable = 1;
		
		//Prueba
		@(posedge clk)
		enable = 1;
		@(posedge clk)
		enable = 1;
		@(posedge clk)
		enable = 1;
		//*************
		@(posedge clk)
		enable = 0;
		@(posedge clk)
		enable = 0;
		@(posedge clk)
		enable = 0;
		//#100;
		$fdisplayb(I_PD, IPD);
		//#100;
	end
	$fclose(I_PD);//cierra el fichero Documento
	$stop;
	end
      
endmodule


