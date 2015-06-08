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

wire signed [N-1:0]error, integrador, proporcional, derivador, Integrador_Proporcional, Registro_y, Registro_r;

reg [1:0] valor_A;
wire [1:0] Valor_next; 
reg  clockd_A;
wire clockd_next;

always @(posedge clk, posedge reset)
  if (reset)
     begin 
         valor_A <= 0 ;
     clockd_A <= 0 ;
   end   
  else 
     begin 
        valor_A <= Valor_next ;
    clockd_A <= clockd_next ;
   end 
	
   assign Valor_next =  {enable,valor_A[1]};
   assign clockd_next =  (valor_A==2'b11) ? 1'b1 :
                     (valor_A==2'b00) ? 1'b0 :
          clockd_A;
          
 assign fall_edge =  ~clockd_A & clockd_next ;

Registro_Pipeline #(.N(N)) Reg_y (
    .clk(clk), 
    .reset(reset), 
    .data_in(y), 
    .enable(fall_edge), 
    .q_out(Registro_y)
    );
	 
Registro_Pipeline #(.N(N)) Reg_r (
    .clk(clk), 
    .reset(reset), 
    .data_in(referencia), 
    .enable(fall_edge), 
    .q_out(Registro_r)
    );
	 
CalculoError #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) ERROR (
    .referencia(Registro_r), 
    .y(Registro_y), 
    .error(error)
    );

Integrador #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) INTEGRADOR (
    .clk(clk), 
    .reset(reset), 
    .enable(fall_edge), 
    .error(error),
    .integrador(integrador)
    );
	 
Proporcional #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) PROPORCIONAL (
    .clk(clk), 
    .reset(reset),
	 .y(Registro_y), 
    .proporcional(proporcional)
    );
	 
Derivador #(.Magnitud(Magnitud), .Decimal(Decimal), .N(N)) DERIVADOR (
    .clk(clk), 
    .reset(reset), 
    .enable(fall_edge), 
    .y(Registro_y), 
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
