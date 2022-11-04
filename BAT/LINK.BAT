:: linka os objetos contidos na pasta OBJ e cria executavel final
:: A ordem com que os parametros aparecem importa!!! Devem ficar na mesma ordem com que são chamados durante a rotina de execução do programa, para evitar que o call interprete saltos para trás (de valor negativo) como saltos para frente (de valor positivo), visto que os saltos são do tipo unsigned
:: Caso o tamanho do comando exceda o numero maximo de caracteres do msdos
:: SET OBJ=C:\%objFolder%
%exeFolder%\freelink %objFolder%\main %objFolder%\teclado %objFolder%\menu %objFolder%\bg %objFolder%\anim %objFolder%\rect %objFolder%\circ %objFolder%\line %objFolder%\gameloop %objFolder%\plot_xy %objFolder%\data,%projName%
