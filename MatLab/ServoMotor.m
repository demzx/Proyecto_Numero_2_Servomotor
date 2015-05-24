y1 = 0;
i1 = 0;
Sal=fopen('Salida.txt', 'wt');
ref = fopen('Referencia.txt', 'wt');
ye = fopen('y.txt', 'wt');

ref_binario = fopen('Referencia_Binario.txt', 'wt');
ye_binario = fopen('y_Binario.txt', 'wt');

for k = 1:5000
    
    r = (25*k) - 1;
    y = (10*k) + 2;
    fprintf(ref, '%f \n', r);
    fprintf(ye, '%f \n', y);
    
    r_binAux1 = decimalToBinaryVector(r,17);
    r_binAux2 = [0 r_binAux1];
    r_bin = num2str(r_binAux2);
    
    y_binAux1 = decimalToBinaryVector(y,17);
    y_binAux2 = [0 y_binAux1];
    y_bin = [0 num2str(y_binAux2)];
    
    fprintf(ref_binario, '%s \n', r_bin);
    fprintf(ye_binario, '%s \n', y_bin);
    
    e = r - y;
    
    p = 18 * y;
    i = 7 * e + i1;
    d = 150 * (y - y1);
    PID = i - p - d;
    
    y1 = y;
    i1 = i;
    
    sal = (((PID/128)*256)/3.3);
%     CicloTrabajo = (100*sal)/255;
%     TensionSalida = (3.3*CicloTrabajo)/100;
%     y = TensionSalida;
    fprintf(Sal, '%f \n', PID);
end
fclose(Sal);

fclose(ref);
fclose(ye);

fclose(ref_binario);
fclose(ye_binario);

load Salida.txt;
Tiempo = 1:5000;
plot(Tiempo, Salida);

