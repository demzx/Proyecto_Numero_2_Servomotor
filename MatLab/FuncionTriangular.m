
triang = fopen('Triangulo.txt', 'wt');
for i = 1:200
    if (i < 100)
        y = 10*i;
    else
        y = -10*i + 2000;
    end
    fprintf(triang, '%f \n', y);
end

fclose(triang);

load Triangulo.txt;
Tiempo = 1:200;
plot(Tiempo, Triangulo);