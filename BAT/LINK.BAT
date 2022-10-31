:: linka os objetos contidos na pasta OBJ e cria executavel final
:: A ordem com que os parametros aparecem importa!!! Devem ficar na mesma ordem com que são chamados durante a rotina de execução do programa, para evitar que o call interprete saltos para trás (de valor negativo) como saltos para frente (de valor positivo), visto que os saltos são do tipo unsigned
%exeFolder%\freelink %objFolder%\main.obj %objFolder%\teclado.obj %objFolder%\menu.obj %objFolder%\plot_xy.obj %objFolder%\line.obj %objFolder%\data.obj,%projName%.exe
