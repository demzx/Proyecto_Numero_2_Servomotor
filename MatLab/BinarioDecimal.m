load Salida_I_PD.txt

d = binaryVectorToDecimal(Salida_I_PD);

Salida_IPD_Verilog = fopen('SalidaDecimalVerilog.txt', 'wt');
fprintf(Salida_IPD_Verilog, '%f \n', d);
fclose(Salida_IPD_Verilog);

load Salida.txt
load Triangulo.txt

t = 1:93;


subplot(2,1,1), plot(t, Salida, 'bla');
title('Salida IPD MatLab')
subplot(2,1,2), plot(t, d);
title('Salida IPD Verilog')
