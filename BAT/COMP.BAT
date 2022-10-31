:: cria os objetos dos arquivos assembly
md %objFolder%
md %lstFolder%
%exeFolder%\nasm16 -f obj -o %objFolder%\main.obj -l %lstFolder%\main.lst %asmFolder%\main.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\teclado.obj -l %lstFolder%\teclado.lst %asmFolder%\teclado.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\data.obj -l %lstFolder%\data.lst %asmFolder%\data.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\menu.obj -l %lstFolder%\menu.lst %asmFolder%\menu.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\plot_xy.obj -l %lstFolder%\plot_xy.lst %asmFolder%\plot_xy.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\line.obj -l %lstFolder%\line.lst %asmFolder%\line.asm
