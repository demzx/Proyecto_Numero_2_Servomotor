y1 = 0;
i1 = 0;
Sal=fopen('Salida.txt', 'wt');
ref = fopen('Referencia.txt', 'wt');
ye = fopen('y.txt', 'wt');

propor = fopen('proporcional.txt', 'wt');
inte = fopen('integrador.txt', 'wt');
deri = fopen('derivador.txt', 'wt');

%Revision Integrador

Multw = fopen('Multiplicacion.txt', 'wt');
Sumw = fopen('Suma.txt', 'wt');
Regis = fopen('Registro.txt', 'wt');

%**************************************************

load Triangulo.txt

ref_binario = fopen('Referencia_Binario.txt', 'wt');
ye_binario = fopen('y_Binario.txt', 'wt');

for k = 1:93
   
    r = 500;
    y = (Triangulo(k));
    fprintf(ref, '%f \n', r);
    fprintf(ye, '%f \n', y);
    
    
    r_binAux1 = decimalToBinaryVector(r,11);
    r_binAux2 = [0 r_binAux1];
    r_bin = num2str(r_binAux2);
    
    y_binAux1 = decimalToBinaryVector(y,11);
    y_binAux2 = [0 y_binAux1];
    y_bin = [0 num2str(y_binAux2)];
    
    fprintf(ref_binario, '%s \n', r_bin);
    fprintf(ye_binario, '%s \n', y_bin);
     %Estas referencias estan hechas con el offset de 2048 para que calcen
    y = y -2048;
    r = r -2048;
    
    e = r - y;
    
    p = 18 * y;
    i = 7 * e + i1;
    %
    iAux1 = 7*e;
    iAux2 = iAux1 + i1;
    d = 150 * (y - y1);
    PID = i - p - d;
    
    fprintf(propor, '%f \n', p);
    fprintf(inte, '%f \n', i);
    fprintf(deri, '%f \n', d);
    
    %Revision Integrados
    fprintf(Multw, '%f \n', iAux1);
    fprintf(Sumw, '%f \n', iAux2);
    fprintf(Regis, '%f \n', i1);
    %*********************************
    
    if (PID >= 131072)
        Salida = 131072;
    else
        Salida = PID;
    end
    y1 = y;
    i1 = i;
    
%    sal = (((PID/128)*256)/3.3);
%    CicloTrabajo = (100*sal)/255;
%    TensionSalida = (3.3*CicloTrabajo)/100;
%    y = TensionSalida;
    fprintf(Sal, '%f \n', Salida);
end
fclose(Sal);

fclose(ref);
fclose(ye);

fclose(ref_binario);
fclose(ye_binario);

fclose(propor);
fclose(inte);
fclose(deri);

%Revision Integrador
fclose(Multw);
fclose(Sumw);
fclose(Regis);
%*******************************
load Salida.txt;
Tiempo = 1:93;
plot(Tiempo, Salida);

